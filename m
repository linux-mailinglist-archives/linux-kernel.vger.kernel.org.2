Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35043E1B20
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 20:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241144AbhHESWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 14:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238992AbhHESV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 14:21:59 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CABCC061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 11:21:44 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id e13-20020a056830200db02904f06fa2790cso6095008otp.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 11:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=27qj2SWHf1ITmiEsMbQM8FzGSFNAOy3v+jLUQb3Ja84=;
        b=KfJY1YUJIGR7TvsAVd7lBr89GqNQUjB9YAaf/2DLFZBymgDfomTuzE8vyS0sdSIe2J
         nr/Ctl8RHwIxj3Eul7qbc6jdtiiwEhWoRsLLLigKmKTHYt2o+/J3OcNXjsGVQAIZsoHn
         cpDHhiaY1EBOn8zhBBn/luIB0cbu2eX/LrfddnrjCod/mEUpopCyLhiVtXvj+lRub2Ri
         BfTgteRJAYiYYz26hVBGG0EcE2Z+ddzzXliwuqOJ1TntGB6FcCIK0thOEp1uxj7IAvDc
         j4S9xOpsG+wMpLZUWbUBWi1T6URWvGYcwNSygVQB4XVI1k6ovB6VA9vtlC2GxD2tKZo9
         FZgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=27qj2SWHf1ITmiEsMbQM8FzGSFNAOy3v+jLUQb3Ja84=;
        b=J5qesfzNGaPD3J0olf+pEKokewKGOdTf0aq59f+0H0wguSO+qlVfV28wEw+J7W4xpc
         C9kVYjmXtzHSOLvH+K9A0uRav+G4zdE41pTPDGa3IzT3IC+qanUqHqx5Z+RgDZNwKlqk
         eIwqPo1xN5iRTNyXfdWP0SAS74klC1bKEOOBm8iKXXDab6fBX0DLiCP+LqKSqIqgeDur
         qPLGOBFcqs0JLWV2gm5IbyJa7NSU1hWDZk/OvXiiv9Q5wFsDF5bBmxvJhXq2KqEP6Y1x
         WAeR9sjswmla0jZ2kMtxZkpfwIE744VTRF6UCxTK/C98cNTEOVIWnlnOnOUbPl5E+uwq
         4AGQ==
X-Gm-Message-State: AOAM531xElyL6nU8qr+yqAf8sWoPFBO8HqCJO8PWr7S/GVYfks8LQk/+
        K5lb/mI07dSpQnf9B926G36Z1Lb78XReStfwf+E=
X-Google-Smtp-Source: ABdhPJxEFl9g2uIR7AX/5xRKU2EoUakZ8tDgBO6V/DlWWQ9gFUU2CtMZ7xgrDvbpoNlW+6PhoRR5f5SqhnQmG5wrXhk=
X-Received: by 2002:a05:6830:1c2f:: with SMTP id f15mr4696064ote.23.1628187703609;
 Thu, 05 Aug 2021 11:21:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9twko1gCNTB3CPf7CAQqWFayMj=1fa3ZoEwwviDFhF48kQ@mail.gmail.com>
 <CAHk-=wgYq=EpNmDPNVxnBX+HpjNcQg50DSjuxZuK0UbZjh-pnQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgYq=EpNmDPNVxnBX+HpjNcQg50DSjuxZuK0UbZjh-pnQ@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 5 Aug 2021 14:21:31 -0400
Message-ID: <CADnq5_M7gbOn34_57ipGjfpo7FvB3sFQnSOtkPUvstshX4V-zQ@mail.gmail.com>
Subject: Re: [git pull] drm fixes for 5.14-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>,
        Harry Wentland <hwentlan@amd.com>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>
Cc:     Dave Airlie <airlied@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 5, 2021 at 2:14 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> This might possibly have been fixed already by the previous drm pull,
> but I wanted to report it anyway, just in case.
>
> It happened after an uptime of over a week, so it might not be trivial
> to reproduce.
>
> It's a NULL pointer dereference in dc_stream_retain() with the code being
>
>         lock xadd %eax,0x390(%rdi) <-- trapping instruction
>
> and that's just the
>
>         kref_get(&stream->refcount);
>
> with a NULL 'stream' argument.
>
>   Call Trace:
>    dc_resource_state_copy_construct+0x13f/0x190 [amdgpu]
>    amdgpu_dm_atomic_commit_tail+0xd5/0x1540 [amdgpu]
>    commit_tail+0x97/0x180 [drm_kms_helper]
>    process_one_work+0x1df/0x3a0
>
> the oops is followed by a stream of
>
>   [drm:amdgpu_dm_atomic_check [amdgpu]] *ERROR* [CRTC:55:crtc-1]
> hw_done or flip_done timed out
>
> and the machine was not usable afterwards.
>
> lspci says this is a
>
>  49:00.0 VGA compatible controller [0300]:
>    Advanced Micro Devices, Inc. [AMD/ATI] Ellesmere
>    [Radeon RX 470/480/570/570X/580/580X/590]
>    [1002:67df] (rev e7) (prog-if 00 [VGA controller])
>
> Full oops in the attachment, but I think the above is all the really
> salient details.

Thanks for the report.  Adding some display folks to take a look.

Alex
