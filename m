Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56346424006
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 16:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbhJFO1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 10:27:10 -0400
Received: from srv6.fidu.org ([159.69.62.71]:40766 "EHLO srv6.fidu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231356AbhJFO1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 10:27:08 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id 5D86FC800AA;
        Wed,  6 Oct 2021 16:25:14 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id cK3OxzFKXTNg; Wed,  6 Oct 2021 16:25:14 +0200 (CEST)
Received: from [192.168.178.82] (host-212-18-30-247.customer.m-online.net [212.18.30.247])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPSA id F0CF6C800A8;
        Wed,  6 Oct 2021 16:25:13 +0200 (CEST)
Subject: Re: [PATCH] ALSA: hda/realtek: Add quirk for TongFang PHxTxX1
To:     Takashi Iwai <tiwai@suse.de>
Cc:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20211006130415.538243-1-wse@tuxedocomputers.com>
 <s5hpmsib5wp.wl-tiwai@suse.de>
From:   Werner Sembach <wse@tuxedocomputers.com>
Message-ID: <ca37123b-5779-b546-089b-9af61f68a2b2@tuxedocomputers.com>
Date:   Wed, 6 Oct 2021 16:25:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <s5hpmsib5wp.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 06.10.21 um 16:10 schrieb Takashi Iwai:

> On Wed, 06 Oct 2021 15:04:15 +0200,
> Werner Sembach wrote:
>> This applies a SND_PCI_QUIRK(...) to the TongFang PHxTxX1 barebone. This
>> fixes the issue of the internal Microphone not working after booting
>> another OS.
>>
>> When booting a certain another OS this barebone keeps some coeff settings
>> even after a cold shutdown. These coeffs prevent the microphone detection
>> from working in Linux, making the Laptop think that there is always an
>> external microphone plugged-in and therefore preventing the use of the
>> internal one.
>>
>> The relevant indexes and values where gathered by naively diff-ing and
>> reading a working and a non-working coeff dump.
>>
>> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> Thanks, applied.
>
>
> Takashi

Thanks for being quick as always ^^

I forgot to add cc: stable to the patch. Whats the best practie to do that after the patch has already been applied?

Just send it again mit with cc: stable?

Kind regards,

Werner Sembach

