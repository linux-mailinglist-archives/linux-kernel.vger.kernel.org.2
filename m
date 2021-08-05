Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABB013E1776
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240298AbhHEPCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:02:45 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:56198 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbhHEPCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:02:44 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 219791FE64;
        Thu,  5 Aug 2021 15:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628175749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XBK6IDDHWir8GbqzNbSxQd2rcyeh6iwFHMXEOR7Cd7o=;
        b=TyTJnqK2IFF5JfLfK6NM9rplT46p5M5K3Oc9hXIOb5jsjA2QMalN5oGXaOLOHct3MRBlSK
        MCDj9WqRmjkhRAXDMkKuu6msxn+QcNJ8/5l8t8mexW8gBjrj0qOCcdH7JDIzL0+xUPPUoW
        8lRjjhrtV2TvR9t2sTQp6s8GOH0nJqA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628175749;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XBK6IDDHWir8GbqzNbSxQd2rcyeh6iwFHMXEOR7Cd7o=;
        b=+OmDeC/9K2yV1ceP67qrgpXKjMVK3LpPatD/mrHoHpJEeh1WEr260Fqr++YH20p0A5Rfz6
        ngLzls8O4onNZbBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0937413DA8;
        Thu,  5 Aug 2021 15:02:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dQC2AYX9C2ErcAAAMHmgww
        (envelope-from <dbueso@suse.de>); Thu, 05 Aug 2021 15:02:29 +0000
MIME-Version: 1.0
Date:   Thu, 05 Aug 2021 08:02:28 -0700
From:   Davidlohr Bueso <dbueso@suse.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Michel Lespinasse <michel@lespinasse.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mete Polat <metepolat2000@gmail.com>,
        Jesper Nilsson <jesper@jni.nu>,
        David Woodhouse <dwmw2@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] rbtree: remove unneeded explicit alignment in struct
 rb_node
In-Reply-To: <CAK8P3a3aNuxaEtAiewd+Wjc8hKtca0NrcV2kykkNC-qKT_HhzQ@mail.gmail.com>
References: <20210805133213.700-1-lukas.bulwahn@gmail.com>
 <CAK8P3a3aNuxaEtAiewd+Wjc8hKtca0NrcV2kykkNC-qKT_HhzQ@mail.gmail.com>
User-Agent: Roundcube Webmail
Message-ID: <50ad4c8b848bd371b4b42959167ef03d@suse.de>
X-Sender: dbueso@suse.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-05 07:02, Arnd Bergmann wrote:
> The revert would appear to change the alignment to 16 bits instead
> of 32 bits on m68k as well (not 8 bits as on cris), but I don't know if 
> that
> can cause problems there.

Yeah I tried this a while back and it broke m68k, so it was a no go:

https://lore.kernel.org/lkml/CAMuHMdXeZvJ0X6Ah2CpLRoQJm+YhxAWBt-rUpxoyfOLTcHp+0g@mail.gmail.com/

Thanks,
Davidlohr
