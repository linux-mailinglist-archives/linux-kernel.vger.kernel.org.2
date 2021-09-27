Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD6A8419F2B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 21:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236493AbhI0TcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 15:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236225AbhI0TcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 15:32:22 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8241C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 12:30:43 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id z11so27051709oih.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 12:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G70HjmRcm7pebw7JMA1+BswintokSfzUf7wbPLT3bh8=;
        b=PePbdCn6lrls3OElmo0ChOma4HDqlmsHsEHDorEC1YUw+6b9n0aZGWZXB3GVDPKKp6
         SFE/UG1jAFrArGdtIlr+SMmpgZX+Tr5S36rUZnopGF19M9FSkOl051bYAprEoRP0kOqK
         I16VFG8p8H31MVTOYOmGFk/XcGqvb/mdEmZwMaeDiZhP4+Q7ClirAHP/Zkwy+1+74RgS
         en8o0Y/uSFD+QQy/rZlJPCzjQ2ApgTkH6YndJrOXBVCGcyp/XDnowkKjtg416C13GMb0
         3ll3dkukgB+m23pCQByPJSESGbtr3IMLBgm+cvnj+onS7Tm7U5twqcvoF7+uoHC3Y55b
         DTBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G70HjmRcm7pebw7JMA1+BswintokSfzUf7wbPLT3bh8=;
        b=IDO9ZHGrb14Jj8JDmGcyumc4X6kZ+9vonsd2uJTcn/S7Ih09+Ef7vrFKXuNB3l0ALb
         EZyYigTpmh8wVbNZwxJTUkniN6gciJtM7xMt5pwQGKq7/umXrFaha190n3i7WsKGcDRa
         gPZKVDOkYOwfAbNDFp6FrsTmregCiWEx5ZlL7tCCpX+0HRrm58xfHLGaacRIO4FJqVTn
         f3Tu+yFl5Ns3bOgqc3Q4RbWQry+bZmKBUZnUPwgAJaKAGQzCCRKPlgA4Vv6VLaRUYuDI
         6NH4bXRifUwBgGTktvpEIuMNr0oxNpqTAoEwTP2WObneUipK5yoadjkrbFh7n+R1I5bj
         PXuw==
X-Gm-Message-State: AOAM531uUC3d+6UPvWTPfKD648KSpAuH3OVcXla2oh02nc1U6FVG2SQS
        oUNOggDYqfDMePOS4nSUXplZ9SA/NWMzzNWmRRf1gNoX
X-Google-Smtp-Source: ABdhPJzYEGS+OjFKX6vXPZ4cCYar0OG8DZzI9gg4I3k485PblUEUJxDu4FquDUyTVg+/JA4fTeOgRXLOJZd1R012j6U=
X-Received: by 2002:aca:ab4d:: with SMTP id u74mr599346oie.120.1632771043148;
 Mon, 27 Sep 2021 12:30:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210927122105.942129-1-arnd@kernel.org>
In-Reply-To: <20210927122105.942129-1-arnd@kernel.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 27 Sep 2021 15:30:32 -0400
Message-ID: <CADnq5_NpcW3QctLVqVrMr4ryhkwGJUB85LR4BJEmYidZFQSOfg@mail.gmail.com>
Subject: Re: [PATCH] gpu: amd: replace open-coded offsetof() with builtin
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Evan Quan <evan.quan@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Mon, Sep 27, 2021 at 8:21 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The two AMD drivers have their own custom offsetof() implementation
> that now triggers a warning with recent versions of clang:
>
> drivers/gpu/drm/radeon/radeon_atombios.c:133:14: error: performing pointer subtraction with a null pointer has undefined behavior [-Werror,-Wnull-pointer-subtraction]
>
> Change all the instances to use the normal offsetof() provided
> by the kernel that does not have this problem.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/amd/display/dc/bios/command_table2.c  | 4 +---
>  drivers/gpu/drm/amd/include/atombios.h                | 2 +-
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.h | 4 ++--
>  drivers/gpu/drm/radeon/atombios.h                     | 2 +-
>  4 files changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
> index f1f672a997d7..4f37be727332 100644
> --- a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
> +++ b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
> @@ -44,9 +44,7 @@
>         bp->base.ctx->logger
>
>  #define GET_INDEX_INTO_MASTER_TABLE(MasterOrData, FieldName)\
> -       (((char *)(&((\
> -               struct atom_master_list_of_##MasterOrData##_functions_v2_1 *)0)\
> -               ->FieldName)-(char *)0)/sizeof(uint16_t))
> +       (offsetof(struct atom_master_list_of_##MasterOrData##_functions_v2_1, FieldName) / sizeof(uint16_t))
>
>  #define EXEC_BIOS_CMD_TABLE(fname, params)\
>         (amdgpu_atom_execute_table(((struct amdgpu_device *)bp->base.ctx->driver_context)->mode_info.atom_context, \
> diff --git a/drivers/gpu/drm/amd/include/atombios.h b/drivers/gpu/drm/amd/include/atombios.h
> index 6a505d1b82a5..da895d1f3b4f 100644
> --- a/drivers/gpu/drm/amd/include/atombios.h
> +++ b/drivers/gpu/drm/amd/include/atombios.h
> @@ -7148,7 +7148,7 @@ typedef struct _ATOM_ASIC_INTERNAL_SS_INFO_V3
>  #define GET_COMMAND_TABLE_COMMANDSET_REVISION(TABLE_HEADER_OFFSET) (((static_cast<ATOM_COMMON_TABLE_HEADER*>(TABLE_HEADER_OFFSET))->ucTableFormatRevision )&0x3F)
>  #define GET_COMMAND_TABLE_PARAMETER_REVISION(TABLE_HEADER_OFFSET)  (((static_cast<ATOM_COMMON_TABLE_HEADER*>(TABLE_HEADER_OFFSET))->ucTableContentRevision)&0x3F)
>  #else // not __cplusplus
> -#define   GetIndexIntoMasterTable(MasterOrData, FieldName) (((char*)(&((ATOM_MASTER_LIST_OF_##MasterOrData##_TABLES*)0)->FieldName)-(char*)0)/sizeof(USHORT))
> +#define   GetIndexIntoMasterTable(MasterOrData, FieldName) (offsetof(ATOM_MASTER_LIST_OF_##MasterOrData##_TABLES, FieldName) / sizeof(USHORT))
>
>  #define GET_COMMAND_TABLE_COMMANDSET_REVISION(TABLE_HEADER_OFFSET) ((((ATOM_COMMON_TABLE_HEADER*)TABLE_HEADER_OFFSET)->ucTableFormatRevision)&0x3F)
>  #define GET_COMMAND_TABLE_PARAMETER_REVISION(TABLE_HEADER_OFFSET)  ((((ATOM_COMMON_TABLE_HEADER*)TABLE_HEADER_OFFSET)->ucTableContentRevision)&0x3F)
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.h
> index b7e2651b570b..2fc1733bcdcf 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.h
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.h
> @@ -29,9 +29,9 @@
>  typedef enum atom_smu9_syspll0_clock_id BIOS_CLKID;
>
>  #define GetIndexIntoMasterCmdTable(FieldName) \
> -       (((char*)(&((struct atom_master_list_of_command_functions_v2_1*)0)->FieldName)-(char*)0)/sizeof(uint16_t))
> +       (offsetof(struct atom_master_list_of_command_functions_v2_1, FieldName) / sizeof(uint16_t))
>  #define GetIndexIntoMasterDataTable(FieldName) \
> -       (((char*)(&((struct atom_master_list_of_data_tables_v2_1*)0)->FieldName)-(char*)0)/sizeof(uint16_t))
> +       (offsetof(struct atom_master_list_of_data_tables_v2_1, FieldName) / sizeof(uint16_t))
>
>  #define PP_ATOMFWCTRL_MAX_VOLTAGE_ENTRIES 32
>
> diff --git a/drivers/gpu/drm/radeon/atombios.h b/drivers/gpu/drm/radeon/atombios.h
> index 83e8b8547f9b..bd5dc09e860f 100644
> --- a/drivers/gpu/drm/radeon/atombios.h
> +++ b/drivers/gpu/drm/radeon/atombios.h
> @@ -5983,7 +5983,7 @@ typedef struct _ATOM_ASIC_INTERNAL_SS_INFO_V3
>  #define GET_COMMAND_TABLE_COMMANDSET_REVISION(TABLE_HEADER_OFFSET) (((static_cast<ATOM_COMMON_TABLE_HEADER*>(TABLE_HEADER_OFFSET))->ucTableFormatRevision )&0x3F)
>  #define GET_COMMAND_TABLE_PARAMETER_REVISION(TABLE_HEADER_OFFSET)  (((static_cast<ATOM_COMMON_TABLE_HEADER*>(TABLE_HEADER_OFFSET))->ucTableContentRevision)&0x3F)
>  #else // not __cplusplus
> -#define        GetIndexIntoMasterTable(MasterOrData, FieldName) (((char*)(&((ATOM_MASTER_LIST_OF_##MasterOrData##_TABLES*)0)->FieldName)-(char*)0)/sizeof(USHORT))
> +#define        GetIndexIntoMasterTable(MasterOrData, FieldName) (offsetof(ATOM_MASTER_LIST_OF_##MasterOrData##_TABLES, FieldName)/sizeof(USHORT))
>
>  #define GET_COMMAND_TABLE_COMMANDSET_REVISION(TABLE_HEADER_OFFSET) ((((ATOM_COMMON_TABLE_HEADER*)TABLE_HEADER_OFFSET)->ucTableFormatRevision)&0x3F)
>  #define GET_COMMAND_TABLE_PARAMETER_REVISION(TABLE_HEADER_OFFSET)  ((((ATOM_COMMON_TABLE_HEADER*)TABLE_HEADER_OFFSET)->ucTableContentRevision)&0x3F)
> --
> 2.29.2
>
