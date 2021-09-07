Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAE5B402ECA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 21:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345654AbhIGTN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 15:13:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:50654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230203AbhIGTN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 15:13:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 486ED610C8;
        Tue,  7 Sep 2021 19:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631041940;
        bh=9dkQcKP1D9mdioHnIChZqnmsDboQySZbW/TMDmx+WWs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=clAQUC6SwmKmhM7Qwd+RtfwMyGn1b093W6hhyo1brvjtPB1qK8jdjMbezgXXpvBE+
         wzY+kqApuwW6Ye1+4NeAslJt8y4Ydh8IDzbuiwW/PDotEA1edhpcXq/Zmlmv/GSFTt
         aoxaHnsC1B/UDMpMHRCF3oT/epmQpV2XOt//JciIx7/txk6boVcb1QTxkiLb2dMXhg
         jj/l6zy7vIv4FOR/ZYlAvM+5GUw2L5FM5u560Vu2zQFK9LNXVVATCIbOoDsWwDL48H
         blknugrpqYHdFSoX9BKoJeFurqnvUsVPh+sfeqM4vhwV4X1+T2EtcLc2iuSNxl1IOe
         RTi3WJB4/egZg==
Subject: Re: [PATCH] Enable '-Werror' by default for all kernel builds
To:     Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, Nick Desaulniers <ndesaulniers@google.com>
References: <20210906142615.GA1917503@roeck-us.net>
 <CAHk-=wgjTePY1v_D-jszz4NrpTso0CdvB9PcdroPS=TNU1oZMQ@mail.gmail.com>
 <YTbOs13waorzamZ6@Ryzen-9-3900X.localdomain>
 <CAK8P3a3_Tdc-XVPXrJ69j3S9048uzmVJGrNcvi0T6yr6OrHkPw@mail.gmail.com>
 <CAHk-=wgZkQ+eZ02TaCpAWo_ffiLMwA2tYNHyL+B1dQ4YB0qfmA@mail.gmail.com>
 <1b7cac01-adab-e2d4-769b-b14ed8903ad9@roeck-us.net>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <4063ef23-d769-167f-75b4-6a27cee5ecba@kernel.org>
Date:   Tue, 7 Sep 2021 12:12:19 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1b7cac01-adab-e2d4-769b-b14ed8903ad9@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/2021 10:48 AM, Guenter Roeck wrote:
> On 9/7/21 10:10 AM, Linus Torvalds wrote:
>> On Tue, Sep 7, 2021 at 2:11 AM Arnd Bergmann <arnd@kernel.org> wrote:
>>>
>>>> x86_64-alpine.log:drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c:452:13: 
>>>> error: stack frame size (1800) exceeds limit (1280) in function 
>>>> 'dcn_bw_calc_rq_dlg_ttu' [-Werror,-Wframe-larger-than]
>>>> x86_64-alpine.log:drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn21/display_rq_dlg_calc_21.c:1657:6: 
>>>> error: stack frame size (1336) exceeds limit (1280) in function 
>>>> 'dml21_rq_dlg_get_dlg_reg' [-Werror,-Wframe-larger-than]
>>>> x86_64-alpine.log:drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_rq_dlg_calc_30.c:1831:6: 
>>>> error: stack frame size (1352) exceeds limit (1280) in function 
>>>> 'dml30_rq_dlg_get_dlg_reg' [-Werror,-Wframe-larger-than]
>>>> x86_64-alpine.log:drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_rq_dlg_calc_31.c:1676:6: 
>>>> error: stack frame size (1336) exceeds limit (1280) in function 
>>>> 'dml31_rq_dlg_get_dlg_reg' [-Werror,-Wframe-larger-than]
>>>> x86_64-alpine.log:drivers/vhost/scsi.c:1831:12: error: stack frame 
>>>> size (1320) exceeds limit (1280) in function 'vhost_scsi_release' 
>>>> [-Werror,-Wframe-larger-than]
>>>>
> 
> FWIW, the above is because of
> 
> static void vhost_scsi_flush(struct vhost_scsi *vs)
> {
>          struct vhost_scsi_inflight *old_inflight[VHOST_SCSI_MAX_VQ];
> 
> where VHOST_SCSI_MAX_VQ=128. Presumably some versions of clang inline
> this function. gcc has the same problem here - its stack frame size is
> also > 1024 for vhost_scsi_flush().

Good to know. When investigating these, I intend to compare against GCC 
to see what the difference is to know if it is a problem with the code 
or a compiler issue.

Cheers,
Nathan

