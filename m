Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 648A83263F7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 15:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbhBZOWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 09:22:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44103 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229946AbhBZOWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 09:22:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614349277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fg24dKMXsylujCf9pV0ZPia44btO5GQG0RuB65YXV5I=;
        b=gEQFvaZ8IaWkwZlsHwbrTZwisHvgrrrrrxa/8f+fF5fpyUN/FtPWMunspMxVCZXpkmzGse
        Cx4gBwPejPH1wDn8rN0JpHCYDboiVE63mm4CVDUewK58gQMoq5HKlMPz7NA8FItFFNR882
        p+GTZzjtCRoD+kTnigd2muuryoC/88w=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-TuFBjM0mPkespy0E26Rhow-1; Fri, 26 Feb 2021 09:21:15 -0500
X-MC-Unique: TuFBjM0mPkespy0E26Rhow-1
Received: by mail-ed1-f69.google.com with SMTP id l23so4588479edt.23
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 06:21:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fg24dKMXsylujCf9pV0ZPia44btO5GQG0RuB65YXV5I=;
        b=hwUS6g7YOOA5Zvlnf4+fVGnwnFirExkDBvlXNCeQssjFofk8MxYbd9REabIvAsEYMs
         0UMsyem4JnHx4S9k8eKMlNmcLUlIrNC9+iZL+HnS/Bj2NXkkJxMFin+Z1Q5w+NjExeqq
         6MizwhXKYSjSqQEWkliL8BLOpUBSYvq8xs8uZqw95HrPEnDj38vdbugyPqQyVPkueCNE
         tn92TEAqY82DDmGWSX7uclFYMG1IqSRVvHK/NcTcyAhE93RsIxXZFiY05ANS3aaosADw
         6j53fyVoKaGUbCAmdZqv+CiRurSWKyIQbsAaRAVuwUxrisRXowPXXZR1uqbEtGYBE6D/
         wjbw==
X-Gm-Message-State: AOAM532AixsLDqTAYitp8ayO82Tuv7Ru88l1GrkOTjA0Qiss+eJGgpjR
        nLkffFwzAv28BLiO1mnBUJ5bhMTkMgbqIdtHDHnqS3aZblYufY8OYbkLj3LX9JS8/KfRx4ELpUY
        aQdBUAkgJ0+s6giB2t6Y2IHV3
X-Received: by 2002:a50:fd84:: with SMTP id o4mr3589774edt.382.1614349273760;
        Fri, 26 Feb 2021 06:21:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwF+Kv12vY8XbNfuGeemSm2a6jx6vRslVESjaNVm1YkQa90zOI0swxYDiWa2DjC/178r6Bhdw==
X-Received: by 2002:a50:fd84:: with SMTP id o4mr3589755edt.382.1614349273599;
        Fri, 26 Feb 2021 06:21:13 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id hr3sm5204595ejc.41.2021.02.26.06.21.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Feb 2021 06:21:12 -0800 (PST)
Subject: Re: [PATCH 5.4 12/47] KVM: x86: avoid incorrect writes to host
 MSR_IA32_SPEC_CTRL
To:     Thomas Lamprecht <t.lamprecht@proxmox.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jim Mattson <jmattson@redhat.com>,
        Sasha Levin <sashal@kernel.org>
References: <20210104155705.740576914@linuxfoundation.org>
 <20210104155706.339275609@linuxfoundation.org>
 <85e3f488-4ec5-2ad3-26a6-097d532824e1@proxmox.com>
 <4fa31425-3c13-0a4f-167b-6566c6302334@redhat.com>
 <YDjwxF2RyKnsQqF/@kroah.com>
 <34df16e4-06a1-3343-2fd9-5004ec5f5fa1@redhat.com>
 <89a2c659-54d6-59ae-826e-c742efdb784b@proxmox.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b2f0a841-ec29-7463-8b9d-5524186e3a34@redhat.com>
Date:   Fri, 26 Feb 2021 15:21:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <89a2c659-54d6-59ae-826e-c742efdb784b@proxmox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/02/21 15:18, Thomas Lamprecht wrote:
>>> Does that mean I should not take the patch here in this email and that
>>> you will submit it after some timeperiod, or that I should take this
>>> patch as-is?
>> The patch that Thomas requested (commit 841c2be09fe) does not apply cleanly, so I'll take care of sending the backport.
>>
> Note that the patch I added inline in my initial mail here was already
> adapted to apply cleanly, at least on stable-5.4.y
> 
> May not have made that clear enough, so mentioning it here - ignore me this
> message if that was read and thought of.

No, I just didn't notice at all that you had taken care of backporting 
the patch.  My brain processed it as the quote of the broken patch you 
were replying to...  I wear glasses after all.

Paolo

