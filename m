Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17B83EAC70
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 23:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237192AbhHLVh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 17:37:59 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:45856 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233283AbhHLVhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 17:37:52 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CC7E8222C7;
        Thu, 12 Aug 2021 21:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628804245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OBC+Ip/ULJOXCNVRTtroamB32iZ5vBe8PL4RH2vYv3o=;
        b=HLGXxVGCf6YaEjCo2QZAo/EHvXrH0eQE0chSY+I673C0XBPaTiAT0p1Ydx+okssmMpodDL
        B5uePpPxqlWc28XTDS6QE/udqXBTNQitIVNK5d//88MVCRAuQ4fkuqZu7l/mlOEj477IPt
        a+O8mTI0CRDESwQaAFm34AOOJDM7BQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628804245;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OBC+Ip/ULJOXCNVRTtroamB32iZ5vBe8PL4RH2vYv3o=;
        b=LZwyrLR5hwCysoDLBEPMukibK8crqv4NdIFGFiPyA2kA2kHDDQ2wdWTeCZDdTaRgID4AIY
        H6qfePrvlrb9ErCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AB9D513C80;
        Thu, 12 Aug 2021 21:37:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id D+YsKZWUFWHjbAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 12 Aug 2021 21:37:25 +0000
Subject: Re: [ANNOUNCE] v5.14-rc5-rt8
To:     Clark Williams <williams@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        RT <linux-rt-users@vger.kernel.org>
References: <20210810163731.2qvfuhenolq2gdlv@linutronix.de>
 <20210812151803.52f84aaf@theseus.lan>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <58e09984-31fa-2d9e-8c4d-c7813c1d8d54@suse.cz>
Date:   Thu, 12 Aug 2021 23:36:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210812151803.52f84aaf@theseus.lan>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/12/21 10:18 PM, Clark Williams wrote:
> On Tue, 10 Aug 2021 18:37:31 +0200
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
>
> Sebastian, et al,
> 
> Got the following panic running v5.14-rc5-rt8:

BTW, which was the last version that worked for you in this test?
The SLUB changes in rt8 should have been minimal, and related to
hotplug. On the other hand, if the previous working one was v5.14-rc4
based, the problem could be in rc5...
