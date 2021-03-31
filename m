Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 207F934F667
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 03:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbhCaBwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 21:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbhCaBwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 21:52:01 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2134FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 18:52:01 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id i3so18491251oik.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 18:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HtluysCGFxvzN56Isuc00e1wSGT37UHuugimY4P6e2Q=;
        b=A+GU4x1wUuvV5UDG2gYxrtQQ0RjNlOlLAz5nYn717+qL+TgARU+SqiN5x2Pykc+1Tc
         umt0O0lcT5NaO5t6mgnryT4lassppRACJ5rilxILRjSekVqWpSUhuctM1l22NSL3OAsF
         npMMUUddpggPbkCod2lpm7yAKA0QNOZrOUIRU1XfYo+XVJFRPh9aLVLin2qoL2wwFLVr
         ktC8sw1D0CQy4OBcU6SkIWFBa643p+bHGe0GR3ApDepo+o5Ui/8NYD0MNDwtnzeltaop
         n2TPoLKCsZSUtfem6heccsWbLaxnzzCkWoTgcVaQffqsYpoEiWjXhp6/NjSi8Bh5IHVb
         2yzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HtluysCGFxvzN56Isuc00e1wSGT37UHuugimY4P6e2Q=;
        b=lT3BukOjpNPijqXgP/0PWsuC/nMnSN6g6ZfN63MUq1aDxrDUQajVwbGfGiAbP3BAql
         IMP9spZ8niGxnDGFOhenDmjNXTHPLKgez5wUCr5PbuJojFU6P7ZGH1bXzrGM+0ZGVbJh
         j5WQt6A+HKPsSCsf79kbMg43LMFVySaSzk4GQE0+P0bRxBWl7SPLNZfMLlL+FfjergQV
         b+LgZCw/Ho2xdzToHqTxiffH255eogE07dtF3SaD3kYc/f5N1xuKlmtr0Xy9UMUu7zH6
         dusVfxfiFGPizSRblp4kpsBLwip18/NXVN0dWyrozAsGXeo6H9LiiabAXLfvnJtR5LtT
         Aw7A==
X-Gm-Message-State: AOAM530znbHpE1lqzXwto0Kr/g0qJrJzIw2Zw6YNJUFxXs83IJi8rsSF
        bwbzhY4TvQIYzkO7PINWNRObrZW7OkYspcmD7A+grHKX
X-Google-Smtp-Source: ABdhPJz/7dbdBU45JLef4FhLi4Qwoujuc2g4zJNn2YZIExfKNONOdsC0gaS8kqKALwAuaONuz45RiK2wVvZmj6crRL0=
X-Received: by 2002:aca:4748:: with SMTP id u69mr559928oia.5.1617155520385;
 Tue, 30 Mar 2021 18:52:00 -0700 (PDT)
MIME-Version: 1.0
References: <CADnq5_PSnvFAcUt7T9q=L8v6sFGnLM72cot=Lq_+cs8cNHK5sg@mail.gmail.com>
 <ADoALwDyDqqKqolXZoBMHqqQ.3.1617068062644.Hmail.wanjiabing@vivo.com>
In-Reply-To: <ADoALwDyDqqKqolXZoBMHqqQ.3.1617068062644.Hmail.wanjiabing@vivo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 30 Mar 2021 21:51:49 -0400
Message-ID: <CADnq5_OcwwX43cJho_fw5L2VYTt5Jsh3S9H_GVO5_8OM8PoTTA@mail.gmail.com>
Subject: Re: Re: [PATCH] amd: display: dc: struct dc_state is declared twice
To:     =?UTF-8?B?5LiH5a625YW1?= <wanjiabing@vivo.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Aric Cyr <aric.cyr@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Krunoslav Kovac <Krunoslav.Kovac@amd.com>,
        Jacky Liao <ziyu.liao@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Wenjing Liu <wenjing.liu@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, kael_w@yeah.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 9:36 PM =E4=B8=87=E5=AE=B6=E5=85=B5 <wanjiabing@viv=
o.com> wrote:
>
>
> >On Sat, Mar 27, 2021 at 3:28 AM Wan Jiabing <wanjiabing@vivo.com> wrote:
> >>
> >> struct dc_state has been declared at 273rd line.
> >> Remove the duplicate.
> >> Delete duplicate blank lines.
> >
> >Can you split these into separate patches?
> >
> >Alex
>
> OK. But in fact, what I did  is simple.
> The most important thing is removing the duplicate
> struct dc_state declaration at 585th line.
> Others are all deleting duplicate blank lines.
>
> So maybe I should send two patchs, one is removing
> duplicate declaration, the other is deleting blank lines?
>

Yes.  There are so many whitespace changes in the commit that it's
hard to see the functional change.

Alex


> >>
> >> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> >> ---
> >>  drivers/gpu/drm/amd/display/dc/dc.h | 10 ----------
> >>  1 file changed, 10 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd=
/display/dc/dc.h
> >> index 18ed0d3f247e..dc667298ab5b 100644
> >> --- a/drivers/gpu/drm/amd/display/dc/dc.h
> >> +++ b/drivers/gpu/drm/amd/display/dc/dc.h
> >> @@ -234,7 +234,6 @@ struct dc_static_screen_params {
> >>         unsigned int num_frames;
> >>  };
> >>
> >> -
> >>  /* Surface update type is used by dc_update_surfaces_and_stream
> >>   * The update type is determined at the very beginning of the functio=
n based
> >>   * on parameters passed in and decides how much programming (or updat=
ing) is
> >> @@ -272,7 +271,6 @@ struct dc;
> >>  struct dc_plane_state;
> >>  struct dc_state;
> >>
> >> -
> >>  struct dc_cap_funcs {
> >>         bool (*get_dcc_compression_cap)(const struct dc *dc,
> >>                         const struct dc_dcc_surface_param *input,
> >> @@ -281,7 +279,6 @@ struct dc_cap_funcs {
> >>
> >>  struct link_training_settings;
> >>
> >> -
> >>  /* Structure to hold configuration flags set by dm at dc creation. */
> >>  struct dc_config {
> >>         bool gpu_vm_support;
> >> @@ -581,7 +578,6 @@ struct dc_bounding_box_overrides {
> >>         int min_dcfclk_mhz;
> >>  };
> >>
> >> -struct dc_state;
>
> Removing the duplicate is here.
> And others are all deleting duplicate blank line.
>
> I think they are in the same file. I want to remove the declaration first=
.
> By the way, I deleted the blank line.
>
> Yours,
> Wan Jiabing
>
> >>  struct resource_pool;
> >>  struct dce_hwseq;
> >>  struct gpu_info_soc_bounding_box_v1_0;
> >> @@ -757,7 +753,6 @@ enum dc_transfer_func_predefined {
> >>         TRANSFER_FUNCTION_GAMMA26
> >>  };
> >>
> >> -
> >>  struct dc_transfer_func {
> >>         struct kref refcount;
> >>         enum dc_transfer_func_type type;
> >> @@ -770,7 +765,6 @@ struct dc_transfer_func {
> >>         };
> >>  };
> >>
> >> -
> >>  union dc_3dlut_state {
> >>         struct {
> >>                 uint32_t initialized:1;         /*if 3dlut is went thr=
ough color module for initialization */
> >> @@ -784,7 +778,6 @@ union dc_3dlut_state {
> >>         uint32_t raw;
> >>  };
> >>
> >> -
> >>  struct dc_3dlut {
> >>         struct kref refcount;
> >>         struct tetrahedral_params lut_3d;
> >> @@ -1014,7 +1007,6 @@ enum dc_status dc_validate_global_state(
> >>                 struct dc_state *new_ctx,
> >>                 bool fast_validate);
> >>
> >> -
> >>  void dc_resource_state_construct(
> >>                 const struct dc *dc,
> >>                 struct dc_state *dst_ctx);
> >> @@ -1167,7 +1159,6 @@ struct dc_container_id {
> >>         unsigned short productCode;
> >>  };
> >>
> >> -
> >>  struct dc_sink_dsc_caps {
> >>         // 'true' if these are virtual DPCD's DSC caps (immediately up=
stream of sink in MST topology),
> >>         // 'false' if they are sink's DSC caps
> >> @@ -1229,7 +1220,6 @@ struct dc_cursor {
> >>         struct dc_cursor_attributes attributes;
> >>  };
> >>
> >> -
> >>  /********************************************************************=
***********
> >>   * Interrupt interfaces
> >>   ********************************************************************=
**********/
> >> --
> >> 2.25.1
> >>
> >> _______________________________________________
> >> dri-devel mailing list
> >> dri-devel@lists.freedesktop.org
> >> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>
>
