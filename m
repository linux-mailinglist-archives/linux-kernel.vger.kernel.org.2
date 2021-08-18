Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41DBB3F03E8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 14:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235649AbhHRMpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 08:45:10 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:40568 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233634AbhHRMpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 08:45:05 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7C4D622065;
        Wed, 18 Aug 2021 12:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629290670; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ydc0Xa0Qi2UmrhOCGiJvOEbT86AEUgdj8LlPA7LoqJU=;
        b=eWAdmWw5jyv14jB+gl+nZWJwCeSVxadiuFxA5NaLm9oZaUQKbCwBUr8b3lDOkQ+C/Qisv+
        gywzhArkgpVZEjDzow9KqO+ymMQj7z5z0cC7QMdTvUcqTT8xE44+lWEnffCW4WGDrxmS0y
        PvVEyBxMPFgIUjBTjKXhF4Lv6v5gsmc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629290670;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ydc0Xa0Qi2UmrhOCGiJvOEbT86AEUgdj8LlPA7LoqJU=;
        b=xt2xX7LIubnglerRkfdkNvxAX6YqOS2uKdAEQLdkw/MB/7G2asxbJHeyO3mKAmV7y6YW67
        g5yRqXio/igYlHAw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 6B5ED1371C;
        Wed, 18 Aug 2021 12:44:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id nFTtGa4AHWGIUwAAGKfGzw
        (envelope-from <dwagner@suse.de>); Wed, 18 Aug 2021 12:44:30 +0000
Date:   Wed, 18 Aug 2021 14:44:30 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>, yi.he@emc.com
Subject: Re: [PATCH] nvme-tcp: Do not reset transport on data digest errors
Message-ID: <20210818124430.hokmfa25lnhxnswu@carbon.lan>
References: <20210805121541.77613-1-dwagner@suse.de>
 <47ef76c6-4430-ca24-405e-a226d4303a39@grimberg.me>
 <20210809090947.luoqaooi7gc6u6yu@carbon>
 <2e91c065-d3c6-1bef-5906-1a4648368894@grimberg.me>
 <20210811103146.ytqj5mqpioiba56x@carbon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811103146.ytqj5mqpioiba56x@carbon.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2021 at 12:31:46PM +0200, Daniel Wagner wrote:
> > It is the correct place, lets see that it doesn't increase the struct.
> 
> It should not according pahole:

Anything I need to do to get this patch accepted?
