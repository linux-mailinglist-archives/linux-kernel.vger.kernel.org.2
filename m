Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDB00402DF5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 19:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344183AbhIGRuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 13:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbhIGRuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 13:50:02 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB3AC061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 10:48:56 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 107-20020a9d0bf4000000b0051b8be1192fso78515oth.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 10:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vJ+gvRBAJLYeXIcZ9ApCagIly/vKGuQEYDnPNSFOA74=;
        b=da/6Y3fG+8wHReQooEtxzXUpiQLf3IWvfdjkVdTLWT2s6Am+/9Clj0sMfgbAubv61Y
         BgT4uzkRcaiQPcRttX181tb2auxOCGD3PEVUztHsICbha/tmxDfRg0dV1PXCM8xc7oLS
         TFK/C/2raqkmh2b053q0mdZwTtvGpYpwY3aUnLP+9xjcGPvXBsSj0XiTKzjD1ANwsvjn
         EdPljMIr1yAVaqIpqmUAgtdHZlBw3Xk+WvEmuqiFZ5Zb+qe+xZX9wubtk0o6dMP3+Idv
         Zv8jazx1DSakndwOsWER90iZnVklgw5Hp4qR0QoJ+OMaIfRPDHK4yK0DGKQSrnamA75g
         63Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vJ+gvRBAJLYeXIcZ9ApCagIly/vKGuQEYDnPNSFOA74=;
        b=cxmMro2jwZpyNbIZyAmuZywrFKtP477okw0OcDp9uNF7cxEtzrcO0WLx+S2slg1WNX
         gqJBVsJoSRIApFsJ/ZMEtohJRMn9jqTNSJBdYjQ0pwlQjDEMV1qNA2WXTac1NvxTlSkL
         uCEzBonrJazoQX1NInfezqC5upXXGV+ohVZfBd1fwy7om8L6bYm2xjmYZW2Qr1Aljqpr
         y82nf2eKmS/zcBiy9A/r+0BPh5rZRipd48zNPetrmo+8qHF+KKtRCr06bGlBbTBu4Hlc
         VTQXrw8UMUZa3mOAk7mCQ/EdGThBGVS54fk7vW5j+DZ810n5Yb6kyOhHraBVARy6/E9j
         uoYQ==
X-Gm-Message-State: AOAM531QFBE1ERXg70iZKMLH1hfx9DXGmP89EXvYXkgLBo+1oEAtjDZA
        W6HslArF/+fWh9ItDa9fF0qREX6+RDQ=
X-Google-Smtp-Source: ABdhPJxKFT6NS8bw70/CxRGAzVzqrsO1KTheuRVbQod9RkhnEixN4kCQw4cIIdPb2n5MrDeRy4MVVg==
X-Received: by 2002:a05:6830:4411:: with SMTP id q17mr16455010otv.48.1631036935500;
        Tue, 07 Sep 2021 10:48:55 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 21sm2378650ooy.5.2021.09.07.10.48.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 10:48:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] Enable '-Werror' by default for all kernel builds
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, Nick Desaulniers <ndesaulniers@google.com>
References: <20210906142615.GA1917503@roeck-us.net>
 <CAHk-=wgjTePY1v_D-jszz4NrpTso0CdvB9PcdroPS=TNU1oZMQ@mail.gmail.com>
 <YTbOs13waorzamZ6@Ryzen-9-3900X.localdomain>
 <CAK8P3a3_Tdc-XVPXrJ69j3S9048uzmVJGrNcvi0T6yr6OrHkPw@mail.gmail.com>
 <CAHk-=wgZkQ+eZ02TaCpAWo_ffiLMwA2tYNHyL+B1dQ4YB0qfmA@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <1b7cac01-adab-e2d4-769b-b14ed8903ad9@roeck-us.net>
Date:   Tue, 7 Sep 2021 10:48:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgZkQ+eZ02TaCpAWo_ffiLMwA2tYNHyL+B1dQ4YB0qfmA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/21 10:10 AM, Linus Torvalds wrote:
> On Tue, Sep 7, 2021 at 2:11 AM Arnd Bergmann <arnd@kernel.org> wrote:
>>
>>> x86_64-alpine.log:drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c:452:13: error: stack frame size (1800) exceeds limit (1280) in function 'dcn_bw_calc_rq_dlg_ttu' [-Werror,-Wframe-larger-than]
>>> x86_64-alpine.log:drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn21/display_rq_dlg_calc_21.c:1657:6: error: stack frame size (1336) exceeds limit (1280) in function 'dml21_rq_dlg_get_dlg_reg' [-Werror,-Wframe-larger-than]
>>> x86_64-alpine.log:drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_rq_dlg_calc_30.c:1831:6: error: stack frame size (1352) exceeds limit (1280) in function 'dml30_rq_dlg_get_dlg_reg' [-Werror,-Wframe-larger-than]
>>> x86_64-alpine.log:drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_rq_dlg_calc_31.c:1676:6: error: stack frame size (1336) exceeds limit (1280) in function 'dml31_rq_dlg_get_dlg_reg' [-Werror,-Wframe-larger-than]
>>> x86_64-alpine.log:drivers/vhost/scsi.c:1831:12: error: stack frame size (1320) exceeds limit (1280) in function 'vhost_scsi_release' [-Werror,-Wframe-larger-than]
>>>

FWIW, the above is because of

static void vhost_scsi_flush(struct vhost_scsi *vs)
{
         struct vhost_scsi_inflight *old_inflight[VHOST_SCSI_MAX_VQ];

where VHOST_SCSI_MAX_VQ=128. Presumably some versions of clang inline
this function. gcc has the same problem here - its stack frame size is
also > 1024 for vhost_scsi_flush().

Guenter
