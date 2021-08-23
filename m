Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 821143F4D73
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 17:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbhHWP1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 11:27:14 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55166 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbhHWP1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 11:27:12 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D341F21FF5;
        Mon, 23 Aug 2021 15:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629732388; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zzNXlRcAHsKm6STMJq4mGozzykusNpq+Qf/hEUad6WM=;
        b=1AXChqteUJFNWbj2o/0GNgcHa4jYElBXHjofi5oyJRId9YO/vq+uxX16e+V/5AsvJEofgy
        MpuIRdEFNFvitS5T106TQOUKJtj829lmHWPfxbkVTkNHx3dI8wxflbVD98AT6dkNwBDm/K
        CT/oxPz1VaGDHWLVj1q5hTuLE3VlCQg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629732388;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zzNXlRcAHsKm6STMJq4mGozzykusNpq+Qf/hEUad6WM=;
        b=GhCN9RpxkL0+j78tQz8IcfuFkaWKQvYFME0ox6+WBeIMTdWpH6b39C4KL+OsUmfcF02hAN
        U2YV3rynyBIOZSCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C3B9613BD1;
        Mon, 23 Aug 2021 15:26:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BueULyS+I2FsSAAAMHmgww
        (envelope-from <dbueso@suse.de>); Mon, 23 Aug 2021 15:26:28 +0000
MIME-Version: 1.0
Date:   Mon, 23 Aug 2021 08:26:28 -0700
From:   Davidlohr Bueso <dbueso@suse.de>
To:     Ran Xiaokai <cgel.zte@gmail.com>
Cc:     christian.brauner@ubuntu.com, jamorris@linux.microsoft.com,
        keescook@chromium.org, ktkhai@virtuozzo.com, legion@kernel.org,
        linux-kernel@vger.kernel.org, ran.xiaokai@zte.com.cn,
        varad.gautam@suse.com
Subject: Re: [PATCH] tests: add mqueue sysctl tests for user namespace
In-Reply-To: <20210823032909.45736-1-ran.xiaokai@zte.com.cn>
References: <20210803140133.vksebmgqhlbqipla@wittgenstein>
 <20210823032909.45736-1-ran.xiaokai@zte.com.cn>
User-Agent: Roundcube Webmail
Message-ID: <80849d5c6fb87d1404ec8b2a6d9fe78f@suse.de>
X-Sender: dbueso@suse.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-22 20:29, Ran Xiaokai wrote:

>  create mode 100644 tools/testing/selftests/mqueue_sysctl/Makefile
>  create mode 100644 tools/testing/selftests/mqueue_sysctl/config
>  create mode 100644 
> tools/testing/selftests/mqueue_sysctl/mq_sysctl_test.c

It would be better to use the already existing mqueue directory, instead 
of
creating a new one just for sysctl stuff. Also, while nit, perhaps
mq_sysctl_tests.c (plural) to go with the other naming of the tests...

Thanks,
Davidlohr
