Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70ACA3D1218
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 17:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239771AbhGUOeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 10:34:00 -0400
Received: from m32-153.88.com ([43.250.32.153]:9374 "EHLO email.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239680AbhGUOdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 10:33:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=From:To:Date; bh=YsTvla5cgAwi108hRNsoP1LhXVbbRlotd8OSf
        O8XGe4=; b=nEj8GR+Qjm8qsELfctC4nXddLwSm1MYxSARnT0nAaEjY/NG34/0e/
        I1pxUl4D3bEwbqNA3Acd8FoV1HoxFu4nP32hU5gQKzJgEwJ+b0yoyyRmPw3uZvaA
        3hlIDzOw7OD5sp+1Ms/7M2JmQrC94wF3bmPTeEv2SQ4foCvtI5V2DM=
Received: from localhost.localdomain (unknown [180.120.41.43])
        by v_coremail2-frontend-2 (Coremail) with SMTP id GiKnCgAX7vzOOfhgowVjAA--.246S2;
        Wed, 21 Jul 2021 23:14:23 +0800 (CST)
From:   Hu Haowen <src.res@email.cn>
To:     apw@canonical.com, joe@perches.com
Cc:     dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
        linux-kernel@vger.kernel.org, Hu Haowen <src.res@email.cn>
Subject: [PATCH] checkpatch: add grammatical judgement for total output
Date:   Wed, 21 Jul 2021 23:14:16 +0800
Message-Id: <20210721151416.30530-1-src.res@email.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GiKnCgAX7vzOOfhgowVjAA--.246S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw1UZF4DWry3Gr1rAF47urg_yoW8Gr1rpF
        1rKwn5Xr1Yka48Za1fKr92qry3G34ktFWkGryUGFWayF98G3y7trySkr1Y9ryUKrZ3A3Wa
        gFW0kFW7Gr10v3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgK1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2
        z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc
        02F40EFcxC0VAKzVAqx4xG6I80ewAv7VCjz48v1sIEY20_Cr1UJr1lOx8S6xCaFVCjc4AY
        6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14
        v_XrWl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VWxJr1UJwCFx2IqxVCFs4IE
        7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
        8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWU
        CwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
        1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBI
        daVFxhVjvjDU0xZFpf9x0Jj76p9UUUUU=
X-Originating-IP: [180.120.41.43]
X-CM-SenderInfo: hvufh21hv6vzxdlohubq/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There lacked a English grammatical identification within the final
output of checkpatch.pl such as the following:

    total: 1 errors, 11 warnings, 4094 lines checked
                  ^

Which violated the rule about the usage of the singular form and the
plural form. Hence fix the issue up and make it output the proper
sentence.

Signed-off-by: Hu Haowen <src.res@email.cn>
---
 scripts/checkpatch.pl | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 461d4221e4a4..eec96ed95262 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7439,9 +7439,14 @@ sub process {
 	print report_dump();
 	if ($summary && !($clean == 1 && $quiet == 1)) {
 		print "$filename " if ($summary_file);
-		print "total: $cnt_error errors, $cnt_warn warnings, " .
-			(($check)? "$cnt_chk checks, " : "") .
-			"$cnt_lines lines checked\n";
+		my $errors_str = ($cnt_error == 1) ? "error" : "errors";
+		my $warnings_str = ($cnt_warn == 1) ? "warning" : "warnings";
+		my $checks_str = ($cnt_chk == 1) ? "check" : "checks";
+		my $lines_str = ($cnt_lines == 1) ? "line" : "lines";
+		print "total: $cnt_error $errors_str, " .
+			"$cnt_warn $warnings_str, " .
+			(($check)? "$cnt_chk $checks_str, " : "") .
+			"$cnt_lines $lines_str checked\n";
 	}
 
 	if ($quiet == 0) {
-- 
2.25.1

