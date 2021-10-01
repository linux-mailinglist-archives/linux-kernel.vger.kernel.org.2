Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667E841F5ED
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 21:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhJATx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 15:53:28 -0400
Received: from mail-qk1-f171.google.com ([209.85.222.171]:44571 "EHLO
        mail-qk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbhJATx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 15:53:27 -0400
Received: by mail-qk1-f171.google.com with SMTP id 194so10271985qkj.11;
        Fri, 01 Oct 2021 12:51:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CP2czsJFLPOz9RraUZFgCkPw+6TZRIivrlAU3dXRTyE=;
        b=jg+QsgAHUog8mfT0c45KQX1/4PRfPCun1pet/4a9PXZoQsAlG1/kOX5/wH3uxLJBDK
         RvLMkjQMQ943KYbU5rATWjL1iWFP8gKbgy8MGqVuRUqdN6Kt26UGJLtMNvRqFBm8iVE1
         d09qnOSYw17Gu4zNtWUK4LMlpKo9VI+iwJ1adKTY5i+SjwCbURUkgFVvKYw/pPHfepR1
         uFa2Ta1VEh0EtDN+CPzXpzzz6cgXOmmeFZEXmdtaTxHoh6tlP+vOr9XVQxF7aR4UVG/D
         CrFiGJvSY22Y5J++knE3T/M/igbah1WZGcffrVt+32mhdx7ayCrTQeNzo7lxHbTKaYdA
         CPvw==
X-Gm-Message-State: AOAM531szHzTCyC1MMK8VOIy4VfyO0w8j0SczfrNvyuBiKDcUxCJ0M6u
        5YlMLAjLz2MveX5iziJZpR6FuYXk4RE=
X-Google-Smtp-Source: ABdhPJxiql+SvQ7JhIqib3BIwYulUPpviLXE9ODVRim+NLLN2xt7zDQW2TRN3KJpn8N9QhCcrTeB5g==
X-Received: by 2002:a37:668d:: with SMTP id a135mr10825796qkc.288.1633117901819;
        Fri, 01 Oct 2021 12:51:41 -0700 (PDT)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com. [209.85.160.181])
        by smtp.gmail.com with ESMTPSA id y6sm3423358qkj.26.2021.10.01.12.51.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Oct 2021 12:51:41 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id e16so10090234qts.4;
        Fri, 01 Oct 2021 12:51:41 -0700 (PDT)
X-Received: by 2002:ac8:1e0e:: with SMTP id n14mr14774869qtl.95.1633117900842;
 Fri, 01 Oct 2021 12:51:40 -0700 (PDT)
MIME-Version: 1.0
References: <20211001000924.15421-1-leoyang.li@nxp.com> <4697aa5c-35de-8331-e7a9-831837618477@canonical.com>
In-Reply-To: <4697aa5c-35de-8331-e7a9-831837618477@canonical.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Fri, 1 Oct 2021 14:51:29 -0500
X-Gmail-Original-Message-ID: <CADRPPNRv2n7RHX9=2CTQ25Qce1PNeJnYZ3rt1EwYuCx5Ku5-PQ@mail.gmail.com>
Message-ID: <CADRPPNRv2n7RHX9=2CTQ25Qce1PNeJnYZ3rt1EwYuCx5Ku5-PQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] convert ifc binding to yaml and drop "simple-bus"
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 1, 2021 at 4:46 AM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> On 01/10/2021 02:09, Li Yang wrote:
> > Convert the ifc binding to yaml schema, in the mean while remove the
> > "simple-bus" compatible from the binding to make sure ifc device probes
> > before any of the child devices.  Update the driver and existing DTSes
> > accordingly.
> >
> > DTS changes should be merged together with the driver/binding changes
> > if DTS maintainer is ok with it or after the driver changes are applied.
> >
>
> It's discouraged to merge DTS along with drivers (e.g. soc folks don't
> accept such pull requests), so I propose to apply it in the next cycle.

Ok.  Will separate the DTS changes in the next version.

>
> Best regards,
> Krzysztof
