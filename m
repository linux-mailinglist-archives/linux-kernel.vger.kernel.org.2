Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2337A39774E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 17:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234177AbhFAP6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 11:58:34 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:33236 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhFAP6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 11:58:33 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 332BB2194A;
        Tue,  1 Jun 2021 15:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622563011; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=qGb5tB4jwloRRPIgnn3LUqNEbpCui0+cZLG2IFKN0no=;
        b=TgUDiSkv5XebmZ1R0mW+0NRAxHmjxH1KDh+V41PZ2MKukrmjL3Yjk8odHl3EREyYundquK
        zYSCY5MQseIrX537SOp0chNF735fVszxyL9ySxbLhZyXAcfkr1qPl4A3UeYyPdQrjKZ66J
        DoGJYnemDA6oytbMfwT/uTkZX+CUBbQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622563011;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=qGb5tB4jwloRRPIgnn3LUqNEbpCui0+cZLG2IFKN0no=;
        b=7HLCIFfB1UWeckIg8LmK9U2ie9cOavrPWJNn+jkCDwyVRnVjOLN+6og0Wt+5d1C56Ys5dv
        C3kvQ79xRiw9jQAg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id E44FF118DD;
        Tue,  1 Jun 2021 15:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622563011; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=qGb5tB4jwloRRPIgnn3LUqNEbpCui0+cZLG2IFKN0no=;
        b=TgUDiSkv5XebmZ1R0mW+0NRAxHmjxH1KDh+V41PZ2MKukrmjL3Yjk8odHl3EREyYundquK
        zYSCY5MQseIrX537SOp0chNF735fVszxyL9ySxbLhZyXAcfkr1qPl4A3UeYyPdQrjKZ66J
        DoGJYnemDA6oytbMfwT/uTkZX+CUBbQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622563011;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=qGb5tB4jwloRRPIgnn3LUqNEbpCui0+cZLG2IFKN0no=;
        b=7HLCIFfB1UWeckIg8LmK9U2ie9cOavrPWJNn+jkCDwyVRnVjOLN+6og0Wt+5d1C56Ys5dv
        C3kvQ79xRiw9jQAg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id /BYtNMJYtmCPYAAALh3uQQ
        (envelope-from <lhenriques@suse.de>); Tue, 01 Jun 2021 15:56:50 +0000
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id c074404b;
        Tue, 1 Jun 2021 15:56:50 +0000 (UTC)
Date:   Tue, 1 Jun 2021 16:56:50 +0100
From:   Luis Henriques <lhenriques@suse.de>
To:     Peter Oberparleiter <oberpar@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org
Subject: gcov: NULL pointer dereference with gcc 9.3.1
Message-ID: <YLZYwgs5hyzFZMlw@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Maybe this is a known (gcc?) issue, but I'm seeing a NULL pointer splat if
I instrument my kernel (or a module, more specifically) using gcc 9.3.1.

It looks like, during initialization in __gcov_init(), gcov_info struct is
invalid: the filename seems to be correct but ->function is NULL and
->n_functions contains garbage.  This will result in the NULL pointer if,
for example, I run:

  # echo 1 > /sys/kernel/debug/gcov/reset

Other installed gcc versions (7.5.0 and 10.3.0) work fine.

Is this a know issue with this specific gcc versions?  Anyway, it may
be worth having something like (not tested!):

diff --git a/kernel/gcov/gcc_base.c b/kernel/gcov/gcc_base.c
index 3cf736b9f880..de3ea47f4f62 100644
--- a/kernel/gcov/gcc_base.c
+++ b/kernel/gcov/gcc_base.c
@@ -13,6 +13,11 @@ void __gcov_init(struct gcov_info *info)
 {
 	static unsigned int gcov_version;
 
+	if (!info || !info->functions) {
+		pr_err_once("Invalid gcov_info structure\n");
+		return;
+	}
+
 	mutex_lock(&gcov_lock);
 	if (gcov_version == 0) {
 		gcov_version = gcov_info_version(info);

And also something similar in the clang code, I guess.

I can send a real (tested) patch if you wish, but I just wanted to know if
I'm missing something first.

Cheers,
--
Luis
