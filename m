Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4B740250F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 10:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242355AbhIGIZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 04:25:38 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:33872 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbhIGIZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 04:25:36 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 37B0E21F49;
        Tue,  7 Sep 2021 08:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1631003070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ivtjlHm9PGvCOAfWgUOdjroiZ3RBt7Q0P4cX/o/868Y=;
        b=jZS0iFdgIsAdViWDOfYzzm+0oaqLKQwTQ5/jPYCVb+DekVXTkbClm+CKBs10PQgN2o26ea
        dbb7WejnWOKwKsXoVkSpfkWB3bpd4D5Ec3dro+8ZwDgP8mHnAl8kHDoua+j1KxyMzloPee
        cg4bQ816AVmPQWBitH5e1YjGMLaPr7w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1631003070;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ivtjlHm9PGvCOAfWgUOdjroiZ3RBt7Q0P4cX/o/868Y=;
        b=45GZyTbHAHMEzXY1gUyE7AQkgm8s8nF1p3bfWuW1gJDkX/1f5DuuzU4BCyiui+7jHcq0Fn
        2UYBcDEHaGuUgpBg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id EF93C132AB;
        Tue,  7 Sep 2021 08:24:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 0JwdOL0hN2FJIAAAGKfGzw
        (envelope-from <jdelvare@suse.de>); Tue, 07 Sep 2021 08:24:29 +0000
Date:   Tue, 7 Sep 2021 10:24:28 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] dmi fix for v5.15
Message-ID: <20210907102428.616e5087@endymion>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull dmi subsystem fixes for Linux v5.15 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git dmi-for-linus

 drivers/firmware/dmi-id.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

---------------

Hans de Goede (1):
      firmware: dmi: Move product_sku info to the end of the modalias

Thanks,
-- 
Jean Delvare
SUSE L3 Support
