Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2DC44E501
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 11:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbhKLK7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 05:59:00 -0500
Received: from srv6.fidu.org ([159.69.62.71]:33154 "EHLO srv6.fidu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234814AbhKLK65 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 05:58:57 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id 3BA1EC8009C;
        Fri, 12 Nov 2021 11:56:01 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id tvCNWA5uMmMo; Fri, 12 Nov 2021 11:56:01 +0100 (CET)
Received: from [192.168.178.21] (host-212-18-30-247.customer.m-online.net [212.18.30.247])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPSA id 8F3F2C80099;
        Fri, 12 Nov 2021 11:56:00 +0100 (CET)
Subject: Re: [PATCH] ALSA: hda/realtek: Add quirk for ASRock NUC Box 1100
To:     Takashi Iwai <tiwai@suse.de>
Cc:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20211112094711.963474-1-wse@tuxedocomputers.com>
 <s5h8rxt3cx3.wl-tiwai@suse.de>
From:   Werner Sembach <wse@tuxedocomputers.com>
Message-ID: <db285b5c-9ac7-84b7-3123-1411259f5208@tuxedocomputers.com>
Date:   Fri, 12 Nov 2021 11:56:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <s5h8rxt3cx3.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 12.11.21 um 11:07 schrieb Takashi Iwai:
> On Fri, 12 Nov 2021 10:47:11 +0100,
> Werner Sembach wrote:
>> This applies a SND_PCI_QUIRK(...) to the ASRock NUC Box 1100 series. This
>> fixes the issue of the headphone jack not being detected unless warm
>> rebooted from a certain other OS.
>>
>> When booting a certain other OS some coeff settings are changed that enable
>> the audio jack. These settings are preserved on a warm reboot and can be
>> easily dumped.
>>
>> The relevant indexes and values where gathered by naively diff-ing and
>> reading a working and a non-working coeff dump.
>>
>> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
>> Cc: <stable@vger.kernel.org>
> Thanks, the change looks almost good but in some small details:
>
>> +static void alc233_fixup_asrock_nuc_box_1100_no_audio_jack(struct hda_codec *codec,
>> +							     const struct hda_fixup *fix,
>> +							     int action)
> The function name could be a bit shorter?  It might be possible that
> the fixup could be re-used by others, too.
>
>> +{
>> +	/*
>> +	 * The audio jack input and output is not detected on the ASRock NUC Box 1100 series when
>> +	 * cold booting without this fix. Warm rebooting from a certain other OS makes the audio
>> +	 * functional, as COEF settings are preserved in this case. This fix sets these altered
>> +	 * COEF values as the default.
> Fitting in 80 columns is still preferred, to align with other code.
>
>> +	alc_write_coef_idx(codec, 0x1a, 0x9003);
>> +	alc_write_coef_idx(codec, 0x1b, 0x0e2b);
>> +	alc_write_coef_idx(codec, 0x37, 0xfe06);
>> +	alc_write_coef_idx(codec, 0x38, 0x4981);
>> +	alc_write_coef_idx(codec, 0x45, 0xd489);
>> +	alc_write_coef_idx(codec, 0x46, 0x0074);
>> +	alc_write_coef_idx(codec, 0x49, 0x0149);
> Can be put in the coef_fw table and processed via
> alc_process_coef_fw() instead?
>
>
> thanks,
>
> Takashi

Done. I was not aware of the alc_process_coef_fw() function, thanks.

Testing now and then sending v2.

Kind regards,

Werner Sembach

