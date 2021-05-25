Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF2939027E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 15:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbhEYN3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 09:29:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:51254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233477AbhEYN3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 09:29:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6AED761420;
        Tue, 25 May 2021 13:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621949253;
        bh=vptKd6B+p8qjR8nfeRisIVJqZSsK0IDYsOme9GE5Eu8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WWINi17m5LOTpAvbANxnkmEPG8PqFhqLb6mrEwSM+6LZ8ETYfE+SdslNXXUU+NU0K
         ufroplorCzdp7Ni4iRsII4a6s09BzxHe/ggYS6Yvz18loXYpXTptFNMhS04qDQ8B5i
         wI1wXlmoHKT9EUhEqRlD42uon8Lhab3fISntkqYVFF/ZWHnXX9gjwvjwrtFICEmn3Q
         QqS3lf/tYVrfbSA1VpgVfm7ZS5lTRrb8vbQfRhPrCW3el7D8ueGAIzR31NhN0ObdWX
         PnHHzedNxS/f0DivheHc0cuh12fGzL2UxyHxgthWTLRtQ7LV0dedBgoCM2abW22vaR
         1bdKg05Y+XloQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1llX5m-000uZl-Ek; Tue, 25 May 2021 15:27:30 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] scripts: sphinx-pre-install: rework the sphinx install logic
Date:   Tue, 25 May 2021 15:27:27 +0200
Message-Id: <9dedaec201803017b7a7dc24a074f3a4f040b72a.1621949137.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1621949137.git.mchehab+huawei@kernel.org>
References: <cover.1621949137.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sphinx-pre-install supports installing sphinx via a virtual
environment using pip/pypi or directly from the distribution's
package, when --no-virtualenv is used.

However, even when --no-virtualenv, the current logic is
still recomending to install a virtual env, due to a regression.

It turns that the logic there is complex, as it depends on
several different conditions.

Split the code which recommends Sphinx on two separate
functions, in order to clean up the code.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/sphinx-pre-install | 208 +++++++++++++++++++++++++------------
 1 file changed, 140 insertions(+), 68 deletions(-)

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index fe92020d67e3..b5fec149f473 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -24,7 +24,6 @@ my $need_symlink = 0;
 my $need_sphinx = 0;
 my $need_venv = 0;
 my $need_virtualenv = 0;
-my $rec_sphinx_upgrade = 0;
 my $install = "";
 my $virtenv_dir = "";
 my $python_cmd = "";
@@ -33,6 +32,7 @@ my $cur_version;
 my $rec_version = "1.7.9";	# PDF won't build here
 my $min_pdf_version = "2.4.4";	# Min version where pdf builds
 
+
 #
 # Command line arguments
 #
@@ -319,10 +319,7 @@ sub check_sphinx()
 		return;
 	}
 
-	if ($cur_version lt $rec_version) {
-		$rec_sphinx_upgrade = 1;
-		return;
-	}
+	return if ($cur_version lt $rec_version);
 
 	# On version check mode, just assume Sphinx has all mandatory deps
 	exit (0) if ($version_check);
@@ -701,6 +698,141 @@ sub deactivate_help()
 	printf "\tdeactivate\n";
 }
 
+sub get_virtenv()
+{
+	my $min_activate = "$ENV{'PWD'}/${virtenv_prefix}${min_version}/bin/activate";
+	my @activates = glob "$ENV{'PWD'}/${virtenv_prefix}*/bin/activate";
+
+	@activates = sort {$b cmp $a} @activates;
+	my ($activate, $ver);
+	foreach my $f (@activates) {
+		next if ($f lt $min_activate);
+
+		my $sphinx_cmd = $f;
+		$sphinx_cmd =~ s/activate/sphinx-build/;
+		next if (! -f $sphinx_cmd);
+
+		my $ver = get_sphinx_version($sphinx_cmd);
+		if ($need_sphinx && ($ver ge $min_version)) {
+			return ($f, $ver);
+		} elsif ($ver gt $cur_version) {
+			return ($f, $ver);
+		}
+	}
+	return ("", "");
+}
+
+#
+# The logic here is complex, as it have to deal with different versions:
+#	- minimal supported version;
+#	- minimal PDF version;
+#	- recommended version.
+# It also needs to work fine with both distro's package and venv/virtualenv
+sub recommend_sphinx_version($)
+{
+	my $virtualenv_cmd = shift;
+
+	# Avoid running sphinx-builds from venv if $cur_version is good
+	return if ($cur_version && ($cur_version ge $rec_version));
+
+	my $latest_avail_ver;
+	my $rec_sphinx_upgrade = 0;
+
+	# Get the highest version from sphinx_*/bin/sphinx-build and the
+	# corresponding command to activate the venv/virtenv
+	my ($activate, $venv_ver) = get_virtenv();
+
+	if (($activate ne "") && ($venv_ver gt $cur_version)) {
+		$latest_avail_ver = $venv_ver;
+	} else {
+		$latest_avail_ver = $cur_version if ($cur_version);
+	}
+
+	if (!$need_sphinx) {
+		# sphinx-build is present and its version is >= $min_version
+
+		#only recommend enabling a newer virtenv version if makes sense.
+		if ($latest_avail_ver gt $cur_version) {
+			printf "\nYou may also use the newer Sphinx version $venv_ver with:\n";
+			printf "\tdeactivate\n"  if ($ENV{'PWD'} =~ /${virtenv_prefix}/);
+			printf "\t. $activate\n";
+			deactivate_help();
+
+			return;
+		}
+		return if ($latest_avail_ver ge $rec_version);
+	}
+
+	if (!$virtualenv) {
+		# No sphinx either via package or via virtenv. As we can't
+		# Compare the versions here, just return, recommending the
+		# user to install it from the package distro.
+		return if (!$latest_avail_ver);
+
+		# User doesn't want a virtenv recommendation, but he already
+		# installed one via virtenv with a newer version.
+		# So, print commands to enable it
+		if ($latest_avail_ver gt $cur_version) {
+			printf "\nYou may also use the Sphinx virtualenv version $venv_ver with:\n";
+			printf "\tdeactivate\n"  if ($ENV{'PWD'} =~ /${virtenv_prefix}/);
+			printf "\t. $activate\n";
+			deactivate_help();
+
+			return;
+		}
+		print "\n";
+	} else {
+		$need++ if ($need_sphinx);
+	}
+
+	# Suggest newer versions if current ones are too old
+	if ($latest_avail_ver && $cur_version ge $min_version) {
+		# If there's a good enough version, ask the user to enable it
+		if ($latest_avail_ver ge $rec_version) {
+			printf "\nNeed to activate Sphinx (version $venv_ver) on virtualenv with:\n";
+			printf "\t. $activate\n";
+			deactivate_help();
+
+			return;
+		}
+
+		# Version is above the minimal required one, but may be
+		# below the recommended one. So, print warnings/notes
+
+		if ($latest_avail_ver lt $rec_version) {
+			print "Warning: It is recommended at least Sphinx version $rec_version.\n";
+			$rec_sphinx_upgrade = 1;
+		}
+		if ($latest_avail_ver lt $min_pdf_version) {
+			print "note: If you want pdf, you need at least $min_pdf_version.\n";
+		}
+	}
+
+	# At this point, either it needs Sphinx or upgrade is recommended,
+	# both via pip
+
+	if ($rec_sphinx_upgrade) {
+		if (!$virtualenv) {
+			print "Instead of install/upgrade Python Sphinx pkg, you could use pip/pypi with:\n\n";
+		} else {
+			print "To upgrade Sphinx, use:\n\n";
+		}
+	} else {
+		print "Sphinx needs to be installed either as a package or via pip/pypi with:\n";
+	}
+
+	$python_cmd = find_python_no_venv();
+
+	if ($need_venv) {
+		printf "\t$python_cmd -m venv $virtenv_dir\n";
+	} else {
+		printf "\t$virtualenv_cmd $virtenv_dir\n";
+	}
+	printf "\t. $virtenv_dir/bin/activate\n";
+	printf "\tpip install -r $requirement_file\n";
+	deactivate_help();
+}
+
 sub check_needs()
 {
 	# Check if Sphinx is already accessible from current environment
@@ -763,8 +895,8 @@ sub check_needs()
 	check_program("rsvg-convert", 2) if ($pdf);
 	check_program("latexmk", 2) if ($pdf);
 
-	if ($need_sphinx || $rec_sphinx_upgrade) {
-		check_python_module("ensurepip", 0) if ($need_venv);
+	if ($need_venv) {
+		check_python_module("ensurepip", 0);
 	}
 
 	# Do distro-specific checks and output distro-install commands
@@ -784,67 +916,7 @@ sub check_needs()
 		       which("sphinx-build-3");
 	}
 
-	# NOTE: if the system has a too old Sphinx version installed,
-	# it will recommend installing a newer version using virtualenv
-
-	if ($need_sphinx || $rec_sphinx_upgrade) {
-		my $min_activate = "$ENV{'PWD'}/${virtenv_prefix}${min_version}/bin/activate";
-		my @activates = glob "$ENV{'PWD'}/${virtenv_prefix}*/bin/activate";
-
-		if ($cur_version lt $rec_version) {
-			print "Warning: It is recommended at least Sphinx version $rec_version.\n";
-			print "         If you want pdf, you need at least $min_pdf_version.\n";
-		}
-		if ($cur_version lt $min_pdf_version) {
-			print "Note: It is recommended at least Sphinx version $min_pdf_version if you need PDF support.\n";
-		}
-		@activates = sort {$b cmp $a} @activates;
-		my ($activate, $ver);
-		foreach my $f (@activates) {
-			next if ($f lt $min_activate);
-
-			my $sphinx_cmd = $f;
-			$sphinx_cmd =~ s/activate/sphinx-build/;
-			next if (! -f $sphinx_cmd);
-
-			$ver = get_sphinx_version($sphinx_cmd);
-			if ($need_sphinx && ($ver ge $min_version)) {
-				$activate = $f;
-				last;
-			} elsif ($ver gt $cur_version) {
-				$activate = $f;
-				last;
-			}
-		}
-		if ($activate ne "") {
-			if ($need_sphinx) {
-				printf "\nNeed to activate Sphinx (version $ver) on virtualenv with:\n";
-				printf "\t. $activate\n";
-				deactivate_help();
-				exit (1);
-			} else {
-				printf "\nYou may also use a newer Sphinx (version $ver) with:\n";
-				printf "\tdeactivate && . $activate\n";
-			}
-		} else {
-			my $rec_activate = "$virtenv_dir/bin/activate";
-
-			print "To upgrade Sphinx, use:\n\n" if ($rec_sphinx_upgrade);
-
-			$python_cmd = find_python_no_venv();
-
-			if ($need_venv) {
-				printf "\t$python_cmd -m venv $virtenv_dir\n";
-			} else {
-				printf "\t$virtualenv_cmd $virtenv_dir\n";
-			}
-			printf "\t. $rec_activate\n";
-			printf "\tpip install -r $requirement_file\n";
-			deactivate_help();
-
-			$need++ if (!$rec_sphinx_upgrade);
-		}
-	}
+	recommend_sphinx_version($virtualenv_cmd);
 	printf "\n";
 
 	print "All optional dependencies are met.\n" if (!$optional);
-- 
2.31.1

