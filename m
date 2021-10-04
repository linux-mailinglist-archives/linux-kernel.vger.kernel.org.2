Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB5F42084A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 11:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbhJDJdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 05:33:08 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:44976
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231355AbhJDJdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 05:33:07 -0400
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EF926402CF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 09:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633339877;
        bh=BhMF861qRXxB8JicXlfyBxo5M67ugNaJYcXfYfJhwvs=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=s/0j1vD92J4iRHXcw593uLQq18ySmKQIbdB4G46GY0/dzKwKcgHYANtzezOR4XACS
         enGIenCAHmYV8mu1psecVUuhpppT+6eo2mM5SMVYWn/5FmO/tz5/K9rhQzLhma7d27
         5E8U+5OgVmC8hksm93Tdg3n768wkMDLaIpeSY5Z21Q8x8jeS8DJK/tW1tuUg6Vr8Fc
         I+i9/3+cHPts3iqa0AfK/96S8VRstI7fNk3mb7n7Sky9mVVSQCZSUMOa5bHvxrIiiH
         ZxoLkJsU8RrMHjwKLNa1wY38rgdhrl0ZrrNti7a3h6HLolkGUfBlJbD9vJLJKyWSFF
         o5eM8S5cI5t2A==
Received: by mail-lf1-f71.google.com with SMTP id c42-20020a05651223aa00b003fd328cfeccso2491876lfv.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 02:31:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BhMF861qRXxB8JicXlfyBxo5M67ugNaJYcXfYfJhwvs=;
        b=DsHuCStSUcvdUXeneCz4SVyNfFNpTzGyuA/Ufu49YJ+GJ6Vct4jvWk08qjHCnR+ekK
         hHfW5KexeR/WryB9U2IdUmj1Fw0ziboNR2IzBxA2KY2vjQoPIMRHeaV755o/CnxZDyLT
         3bI6hO+LzQo61HyjJYU1+wWKcmDjGHOisYhOoCE0NhMjSDjyCNzwMJM7kh8Jw66pYie7
         tdZRXAhig74j804fVHTODJyhB1pbTYPrPjUztApgym1gXLRpol5scNwFVg2cbuJgRwbP
         f5UI1aEgKzhR543Yg5v5kc5xkHzyX+uE0/6sHpyQHVFTMEKrndKCmj35lRBCESruVr9+
         58tQ==
X-Gm-Message-State: AOAM531NZ1Y7lrBGDH1cFlDw1uC6mSp8LF8PiK9y7eqEFOb9HIgsgrhx
        XjiKamNklGJhtUoK8ZvWyCSgQBPw6njN+niITfANn+l9yTrNZmPkJHJ+bPUxioVE1Iu0Rk5a/Mb
        zuxpuhHbC+hxmI12nUkM75qeaJwWbTdhhriOMHC1oIA==
X-Received: by 2002:a05:6512:1052:: with SMTP id c18mr13061986lfb.223.1633339876165;
        Mon, 04 Oct 2021 02:31:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzsF7MpTHnCy/j3g+hDSYlF5AGtBdgBEcCWhBbURgsQ+KvwKCwGBOZ9EeWYxDHnkw58Nm6QvQ==
X-Received: by 2002:a05:6512:1052:: with SMTP id c18mr13061970lfb.223.1633339875996;
        Mon, 04 Oct 2021 02:31:15 -0700 (PDT)
Received: from [192.168.0.197] ([193.178.187.25])
        by smtp.gmail.com with ESMTPSA id s29sm1678179ljd.54.2021.10.04.02.31.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Oct 2021 02:31:15 -0700 (PDT)
Subject: Re: [PATCH 1/5] dt-bindings: memory: fsl: convert ifc binding to yaml
 schema
To:     Li Yang <leoyang.li@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <20211001000924.15421-1-leoyang.li@nxp.com>
 <20211001000924.15421-2-leoyang.li@nxp.com>
 <db751cb1-9107-3857-7576-644bde4c28e5@canonical.com>
 <CADRPPNROVBp_QB=6XEgk8WF5fnEPFTSko4Nn+mm8oLM3iGTuuw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <e42fa620-810b-fdcc-c827-602a14d10d97@canonical.com>
Date:   Mon, 4 Oct 2021 11:31:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CADRPPNROVBp_QB=6XEgk8WF5fnEPFTSko4Nn+mm8oLM3iGTuuw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/10/2021 18:17, Li Yang wrote:
> On Fri, Oct 1, 2021 at 5:01 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@canonical.com> wrote:
>>

(...)

>>> +
>>> +  interrupts:
>>> +    minItems: 1
>>> +    maxItems: 2
>>> +    description: |
>>> +      IFC may have one or two interrupts.  If two interrupt specifiers are
>>> +      present, the first is the "common" interrupt (CM_EVTER_STAT), and the
>>> +      second is the NAND interrupt (NAND_EVTER_STAT).  If there is only one,
>>> +      that interrupt reports both types of event.
>>> +
>>> +  little-endian:
>>> +    $ref: '/schemas/types.yaml#/definitions/flag'
>>
>> type: boolean
> 
> It will not have a true or false value, but only present or not.  Is
> the boolean type taking care of this too?

boolean is for a property which does not accept values and true/false
depends on its presence.
See:
Documentation/devicetree/bindings/phy/lantiq,vrx200-pcie-phy.yaml
Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml


Best regards,
Krzysztof
