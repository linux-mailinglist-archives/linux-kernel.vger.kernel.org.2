Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6DF939027D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 15:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbhEYN3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 09:29:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:51242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233475AbhEYN3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 09:29:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 67E7060200;
        Tue, 25 May 2021 13:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621949253;
        bh=zl+iWZs0RYoETvUt9Wps5UdXYD8tR0U9m9C3NgLsriQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=laCNgPf7bI4818k31KUKekw2o0kYkAbxtVMSw6OcUb63MEy+AO0vcvfuoGYOM2SMb
         5LCXSlpfo8iKDn19c+QE+3DzmNQdKp7ZX7pJR+wGWXRm+cssf5Iy0KJQv3toiRnltd
         xq12bOaB7WPQZmseLbpWoPNUO8h9dbzGVUW+NnMNvFqJ14hVF3L7Pe5pEKkW3nnMS1
         xy34YAFjLKK9qlZUj6Qwr0aGkc1gN95LcV21896otrkKrLU6IfNmF5kdnD4/bZuhXR
         5S1cr24mGwXOioOE63tVAmx3tnUROPxJB8FtR0U3HKRgc+YLpG8oGINqHWsDr43EhE
         Wiy60+F0L5zpw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1llX5m-000uZo-G7; Tue, 25 May 2021 15:27:30 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] scripts: sphinx-pre-install: fix the need of virtenv packages
Date:   Tue, 25 May 2021 15:27:28 +0200
Message-Id: <04ce53b77b37f1e495c3abc39c2d3dc407895dc0.1621949137.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1621949137.git.mchehab+huawei@kernel.org>
References: <cover.1621949137.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pip packages are only needed when the distro-provided
Sphinx version is not good enough.

Don't recommend installing it if not needed.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/sphinx-pre-install | 122 ++++++++++++++++++++++---------------
 1 file changed, 74 insertions(+), 48 deletions(-)

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index b5fec149f473..288e86a9d1e5 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -22,16 +22,18 @@ my $need = 0;
 my $optional = 0;
 my $need_symlink = 0;
 my $need_sphinx = 0;
-my $need_venv = 0;
+my $need_pip = 0;
 my $need_virtualenv = 0;
+my $rec_sphinx_upgrade = 0;
 my $install = "";
 my $virtenv_dir = "";
 my $python_cmd = "";
+my $activate_cmd;
 my $min_version;
 my $cur_version;
 my $rec_version = "1.7.9";	# PDF won't build here
 my $min_pdf_version = "2.4.4";	# Min version where pdf builds
-
+my $latest_avail_ver;
 
 #
 # Command line arguments
@@ -700,11 +702,12 @@ sub deactivate_help()
 
 sub get_virtenv()
 {
+	my $ver;
 	my $min_activate = "$ENV{'PWD'}/${virtenv_prefix}${min_version}/bin/activate";
 	my @activates = glob "$ENV{'PWD'}/${virtenv_prefix}*/bin/activate";
 
 	@activates = sort {$b cmp $a} @activates;
-	my ($activate, $ver);
+
 	foreach my $f (@activates) {
 		next if ($f lt $min_activate);
 
@@ -722,6 +725,42 @@ sub get_virtenv()
 	return ("", "");
 }
 
+sub recommend_sphinx_upgrade()
+{
+	my $venv_ver;
+
+	# Avoid running sphinx-builds from venv if $cur_version is good
+	if ($cur_version && ($cur_version ge $rec_version)) {
+		$latest_avail_ver = $cur_version;
+		return;
+	}
+
+	# Get the highest version from sphinx_*/bin/sphinx-build and the
+	# corresponding command to activate the venv/virtenv
+	$activate_cmd = get_virtenv();
+
+	# Store the highest version from Sphinx existing virtualenvs
+	if (($activate_cmd ne "") && ($venv_ver gt $cur_version)) {
+		$latest_avail_ver = $venv_ver;
+	} else {
+		$latest_avail_ver = $cur_version if ($cur_version);
+	}
+
+	# As we don't know package version of Sphinx, and there's no
+	# virtual environments, don't check if upgrades are needed
+	if (!$virtualenv) {
+		return if (!$latest_avail_ver);
+	}
+
+	# Either there are already a virtual env or a new one should be created
+	$need_pip = 1;
+
+	# Return if the reason is due to an upgrade or not
+	if ($latest_avail_ver lt $rec_version) {
+		$rec_sphinx_upgrade = 1;
+	}
+}
+
 #
 # The logic here is complex, as it have to deal with different versions:
 #	- minimal supported version;
@@ -732,30 +771,21 @@ sub recommend_sphinx_version($)
 {
 	my $virtualenv_cmd = shift;
 
-	# Avoid running sphinx-builds from venv if $cur_version is good
+	if ($latest_avail_ver lt $min_pdf_version) {
+		print "note: If you want pdf, you need at least Sphinx $min_pdf_version.\n";
+	}
+
+	# Version is OK. Nothing to do.
 	return if ($cur_version && ($cur_version ge $rec_version));
 
-	my $latest_avail_ver;
-	my $rec_sphinx_upgrade = 0;
-
-	# Get the highest version from sphinx_*/bin/sphinx-build and the
-	# corresponding command to activate the venv/virtenv
-	my ($activate, $venv_ver) = get_virtenv();
-
-	if (($activate ne "") && ($venv_ver gt $cur_version)) {
-		$latest_avail_ver = $venv_ver;
-	} else {
-		$latest_avail_ver = $cur_version if ($cur_version);
-	}
-
 	if (!$need_sphinx) {
 		# sphinx-build is present and its version is >= $min_version
 
 		#only recommend enabling a newer virtenv version if makes sense.
 		if ($latest_avail_ver gt $cur_version) {
-			printf "\nYou may also use the newer Sphinx version $venv_ver with:\n";
+			printf "\nYou may also use the newer Sphinx version $latest_avail_ver with:\n";
 			printf "\tdeactivate\n"  if ($ENV{'PWD'} =~ /${virtenv_prefix}/);
-			printf "\t. $activate\n";
+			printf "\t. $activate_cmd\n";
 			deactivate_help();
 
 			return;
@@ -773,9 +803,9 @@ sub recommend_sphinx_version($)
 		# installed one via virtenv with a newer version.
 		# So, print commands to enable it
 		if ($latest_avail_ver gt $cur_version) {
-			printf "\nYou may also use the Sphinx virtualenv version $venv_ver with:\n";
+			printf "\nYou may also use the Sphinx virtualenv version $latest_avail_ver with:\n";
 			printf "\tdeactivate\n"  if ($ENV{'PWD'} =~ /${virtenv_prefix}/);
-			printf "\t. $activate\n";
+			printf "\t. $activate_cmd\n";
 			deactivate_help();
 
 			return;
@@ -789,8 +819,8 @@ sub recommend_sphinx_version($)
 	if ($latest_avail_ver && $cur_version ge $min_version) {
 		# If there's a good enough version, ask the user to enable it
 		if ($latest_avail_ver ge $rec_version) {
-			printf "\nNeed to activate Sphinx (version $venv_ver) on virtualenv with:\n";
-			printf "\t. $activate\n";
+			printf "\nNeed to activate Sphinx (version $latest_avail_ver) on virtualenv with:\n";
+			printf "\t. $activate_cmd\n";
 			deactivate_help();
 
 			return;
@@ -801,10 +831,6 @@ sub recommend_sphinx_version($)
 
 		if ($latest_avail_ver lt $rec_version) {
 			print "Warning: It is recommended at least Sphinx version $rec_version.\n";
-			$rec_sphinx_upgrade = 1;
-		}
-		if ($latest_avail_ver lt $min_pdf_version) {
-			print "note: If you want pdf, you need at least $min_pdf_version.\n";
 		}
 	}
 
@@ -823,11 +849,8 @@ sub recommend_sphinx_version($)
 
 	$python_cmd = find_python_no_venv();
 
-	if ($need_venv) {
-		printf "\t$python_cmd -m venv $virtenv_dir\n";
-	} else {
-		printf "\t$virtualenv_cmd $virtenv_dir\n";
-	}
+	printf "\t$virtualenv_cmd $virtenv_dir\n";
+
 	printf "\t. $virtenv_dir/bin/activate\n";
 	printf "\tpip install -r $requirement_file\n";
 	deactivate_help();
@@ -854,15 +877,14 @@ sub check_needs()
 		if ($virtualenv) {
 			my $tmp = qx($python_cmd --version 2>&1);
 			if ($tmp =~ m/(\d+\.)(\d+\.)/) {
-				if ($1 >= 3 && $2 >= 3) {
-					$need_venv = 1;		# python 3.3 or upper
-				} else {
-					$need_virtualenv = 1;
-				}
 				if ($1 < 3) {
 					# Fail if it finds python2 (or worse)
 					die "Python 3 is required to build the kernel docs\n";
 				}
+				if ($1 == 3 && $2 < 3) {
+					# Need Python 3.3 or upper for venv
+					$need_virtualenv = 1;
+				}
 			} else {
 				die "Warning: couldn't identify $python_cmd version!";
 			}
@@ -871,14 +893,22 @@ sub check_needs()
 		}
 	}
 
-	# Set virtualenv command line, if python < 3.3
+	recommend_sphinx_upgrade();
+
 	my $virtualenv_cmd;
-	if ($need_virtualenv) {
-		$virtualenv_cmd = findprog("virtualenv-3");
-		$virtualenv_cmd = findprog("virtualenv-3.5") if (!$virtualenv_cmd);
-		if (!$virtualenv_cmd) {
-			check_program("virtualenv", 0);
-			$virtualenv_cmd = "virtualenv";
+
+	if ($need_pip) {
+		# Set virtualenv command line, if python < 3.3
+		if ($need_virtualenv) {
+			$virtualenv_cmd = findprog("virtualenv-3");
+			$virtualenv_cmd = findprog("virtualenv-3.5") if (!$virtualenv_cmd);
+			if (!$virtualenv_cmd) {
+				check_program("virtualenv", 0);
+				$virtualenv_cmd = "virtualenv";
+			}
+		} else {
+			$virtualenv_cmd = "$python_cmd -m venv";
+			check_python_module("ensurepip", 0);
 		}
 	}
 
@@ -895,10 +925,6 @@ sub check_needs()
 	check_program("rsvg-convert", 2) if ($pdf);
 	check_program("latexmk", 2) if ($pdf);
 
-	if ($need_venv) {
-		check_python_module("ensurepip", 0);
-	}
-
 	# Do distro-specific checks and output distro-install commands
 	check_distros();
 
-- 
2.31.1

