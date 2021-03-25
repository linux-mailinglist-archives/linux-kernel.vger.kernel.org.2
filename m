Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD55348E34
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 11:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbhCYKjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 06:39:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:53544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230163AbhCYKic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 06:38:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D7A50619FE;
        Thu, 25 Mar 2021 10:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616668712;
        bh=XdWrZeI0OJ0qNfVpkg0AQG7GblnuxxssfsvEd5dtxGo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r8JCc4UN6XrxF1KDnxhuZzWRfFmh28bw54uWoNVGBVodNE/Ml8d2FlAMIgLK6cUwR
         5YDiA6jC5xPRfmXHd6XQMdaxN7SQuELCS1fUR2WSQyAWkthMlGW8OSpyRDsoyg6/+g
         YHS1mXuR1YR+1l4uKYAkCBmz4zljMhNRd7n5flrzNmH7sg6ksp903JtiP1nbq+GEUR
         djUKdRCQZCDMdaMALq1lZa5MzXJdpv+tcmXLPcwoPUQ+WkelvE3t7QhKk5KQOI+VaB
         G2JCFq1Tw+xSBQq9wVK6kmKldHpxWh9FwFZBKRnhqZ/Gr8AsY/w6eRsUc84VOwjH9i
         0Y9lpAklLKI1g==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lPNNl-001Ava-A5; Thu, 25 Mar 2021 11:38:29 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/7] scripts: get_abi.pl: parse description line per line
Date:   Thu, 25 Mar 2021 11:38:26 +0100
Message-Id: <d33cfa2e59ecf8f28d4ed7de7402468cf2168921.1616668017.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1616668017.git.mchehab+huawei@kernel.org>
References: <cover.1616668017.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the description parsing logic in rst mode in order
to parse it line per line.

The end result is the same, but doing line per line allows
to add some code to escape literal blocks when seeking for
cross-references.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/get_abi.pl | 47 ++++++++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index eb1a23103afa..e5d1da492c1e 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -381,34 +381,41 @@ sub output_rest {
 
 				# Enrich text by creating cross-references
 
-				$desc =~ s,Documentation/(?!devicetree)(\S+)\.rst,:doc:`/$1`,g;
+				my $new_desc = "";
+				open(my $fh, "+<", \$desc);
+				while (my $d = <$fh>) {
+					$d =~ s,Documentation/(?!devicetree)(\S+)\.rst,:doc:`/$1`,g;
 
-				my @matches = $desc =~ m,Documentation/ABI/([\w\/\-]+),g;
-				foreach my $f (@matches) {
-					my $xref = $f;
-					my $path = $f;
-					$path =~ s,.*/(.*/.*),$1,;;
-					$path =~ s,[/\-],_,g;;
-					$xref .= " <abi_file_" . $path . ">";
-					$desc =~ s,\bDocumentation/ABI/$f\b,:ref:`$xref`,g;
-				}
+					my @matches = $d =~ m,Documentation/ABI/([\w\/\-]+),g;
+					foreach my $f (@matches) {
+						my $xref = $f;
+						my $path = $f;
+						$path =~ s,.*/(.*/.*),$1,;;
+						$path =~ s,[/\-],_,g;;
+						$xref .= " <abi_file_" . $path . ">";
+						$d =~ s,\bDocumentation/ABI/$f\b,:ref:`$xref`,g;
+					}
 
-				# Seek for cross reference symbols like /sys/...
-				@matches = $desc =~ m/$xref_match/g;
+					# Seek for cross reference symbols like /sys/...
+					@matches = $d =~ m/$xref_match/g;
 
-				foreach my $s (@matches) {
-					next if (!($s =~ m,/,));
-					if (defined($data{$s}) && defined($data{$s}->{label})) {
-						my $xref = $s;
+					foreach my $s (@matches) {
+						next if (!($s =~ m,/,));
+						if (defined($data{$s}) && defined($data{$s}->{label})) {
+							my $xref = $s;
 
-						$xref =~ s/$symbols/\\$1/g;
-						$xref = ":ref:`$xref <" . $data{$s}->{label} . ">`";
+							$xref =~ s/$symbols/\\$1/g;
+							$xref = ":ref:`$xref <" . $data{$s}->{label} . ">`";
 
-						$desc =~ s,$start$s$bondary,$1$xref$2,g;
+							$d =~ s,$start$s$bondary,$1$xref$2,g;
+						}
 					}
+					$new_desc .= $d;
 				}
+				close $fh;
+
 
-				print "$desc\n\n";
+				print "$new_desc\n\n";
 			} else {
 				$desc =~ s/^\s+//;
 
-- 
2.30.2

