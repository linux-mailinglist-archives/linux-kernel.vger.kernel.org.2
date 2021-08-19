Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C42413F1774
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 12:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238290AbhHSKru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 06:47:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34233 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238142AbhHSKrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 06:47:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629370030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=taTjihhbMgCyTnoTUQ8GyBZ2uW23Ekb/+oHToF9jcgQ=;
        b=XP3XYlE0mzPrTv3YSr7EQrBv74pJPuTssyVTjWNPrw0GFfBEf9zfxB+IbkeD3IenPwxdYx
        pn0D1ZgQpXaoq4bRjriVfL/YyxT29OB1fS7OD2R2y6wzSXsSTTGssBP5Y7GargmCgmUABK
        KiJ2jOZtL367S+vEmEM9DI4Zv4DuCu0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-KkIC6hKDNE-ZPy4WIAftVQ-1; Thu, 19 Aug 2021 06:47:09 -0400
X-MC-Unique: KkIC6hKDNE-ZPy4WIAftVQ-1
Received: by mail-ej1-f71.google.com with SMTP id u23-20020a1709064ad700b005bb12df6cb9so2068138ejt.20
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 03:47:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=taTjihhbMgCyTnoTUQ8GyBZ2uW23Ekb/+oHToF9jcgQ=;
        b=e0mtB/QE5U6F+5Tv2De/RYawhMMrDGt/8T6G835J1k1kfka0Ty8h+t6rCVW9oDq0Sb
         eJBC26hTucuDGJGlPqHUuzZFCiqBOKN2HPhaCNySjjN4l+evmhlkO/GDkEvAXCnzdScg
         0yQboSvpozSa2Z7Isc4ZPn65K9135HFMUiyavyaSOgUsuhTHb4knGjt0NRQ98l514aiv
         3Np3IOqBf1Qrl+kUczomLXK8XFo50CtPWFwwAdFy/8L89Nw1P8ZoxRP7N+koX37o6GtP
         8HvqT9F+qYpGV/3oorRDXOcUGzI6dW8ttHPzieabVCJm2c9BgqNO+C6QzGRknpMwrDe1
         rM5g==
X-Gm-Message-State: AOAM532rthR99u4Mjq0Ir+7lApgykkdlPXknV1rz4uY4OOweqTzWquUB
        Dc5bjZ6UuKzi4pAz/S/sOdUf4k2KEAlp8zNaUvq+JdcfNw17Qaz4e/DxQqcUQT+T8M2pDpAP2lI
        Hnm3LrrXljnrjfMRZMtIqSrTnUybvRqRyBlYc9scIBbBf8FEvvMSp5t8ha3ViCXACFeh6q5z7o3
        Nu
X-Received: by 2002:a17:906:d1d6:: with SMTP id bs22mr14690374ejb.554.1629370028151;
        Thu, 19 Aug 2021 03:47:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzv9RNz+IXs17ZXYng6C5OAs2HyvEgUQELsgCy/6tgwuNq0ME7lFDmY3zHGHHMOLzbRJKQnUg==
X-Received: by 2002:a17:906:d1d6:: with SMTP id bs22mr14690349ejb.554.1629370027898;
        Thu, 19 Aug 2021 03:47:07 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id bm1sm1110292ejb.38.2021.08.19.03.47.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Aug 2021 03:47:07 -0700 (PDT)
Subject: Re: x86/boot/compressed/64: Lenovo Ideapad Miix300 bug report
To:     Borislav Petkov <bp@alien8.de>,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     Joerg Roedel <jroedel@suse.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20210819100230.GA28768@agape.jhs> <YR4uffjFuqvrz1Tp@zn.tnic>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <6d7f217e-f8bb-54c5-844d-4b1dff14c785@redhat.com>
Date:   Thu, 19 Aug 2021 12:47:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YR4uffjFuqvrz1Tp@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/19/21 12:12 PM, Borislav Petkov wrote:
> On Thu, Aug 19, 2021 at 12:02:31PM +0200, Fabio Aiuto wrote:
>> CONFIG_AMD_MEM_ENCRYPT=y
> 
> Lemme see if I understand it correctly: you have this enabled on an
> Intel-based tablet?

Fabio is using the standard Fedora kernels which as generic distro
kernels have this enabled.

He used the Fedora .config when bisecting because in general when
debugging it is a good idea to change as little variables as
possible (even if using a distro-kernel-config leads to long
build times for the bisect).

Regards,

Hans

