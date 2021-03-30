Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEF6934E645
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 13:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbhC3LTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 07:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbhC3LTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 07:19:43 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18504C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 04:19:43 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id f10so11469766pgl.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 04:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nEiq5VYqidlia0rfaVKXey2aQI1J0UOeUfwbZ7SzFqw=;
        b=qIay2yJaGw8H+hG15KImlYeu0r6L9MLLcQDEnZF2qFdTW2zSpQ40IXg+/vxlnJQz4o
         TKzi5YqlKrIHttRWaLvFbdM20gKQ/igZVcwm8SFzdsf0/GzVTOyvvDeB6kqpBolWhn33
         iI+TCXiaVJhMe/oW7DCLEON36LzdAAwFwyEShryYOFQyky1isZ0YY5RVfN5W3oiAYvwy
         8+KnWX/nQwEbJaqACWTSuM18VOAT1ks9X9zr7SchWYDgwTLwBD/knap1CJ7Ca9tlGG8b
         sFpNlx44sNZxtyb4faahEv9qJLV1qWz1e1po03itPLigsO5ao0DVK7AqSPfVLMue7R6H
         nwTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nEiq5VYqidlia0rfaVKXey2aQI1J0UOeUfwbZ7SzFqw=;
        b=CHg5gpTfa0Nu2Jz7RY6ONuzgoAaFb5EDIMHG1qwjQY4z00Hwy556RFvYdId9SdHlHE
         r6QtpmeojmIg5k60cDgGmGOT5a+aAbAJJjMwNsWPaNL8PTn1WoyzsvRln+KwGcxy6fyF
         BU68XJWTLn8Ne4PHT/dQtjbfhmDSkxBa+L5kPFnXmnyMouByjptVkN6ipWDZ3PiUNyNB
         LsiYgFq8b7JE5ftsnBl3mnRT1vjIwQl0w0jJAvu1NSDRrmp64MXBUgbyVdcKBaNCJvP1
         PWR2PS+uTy5IA/eMrf4/cK3tGEQPwl4PSGFLk5HriKuK+3UkFgVMux+p8C9I609tKycp
         UfsQ==
X-Gm-Message-State: AOAM5330E0RK+wU3YZeAUfY0la3hVqHosDi6+njtTr0rI4xqKTEsoNIJ
        fSOuQsZcslZ9gAH8D8uiBy+5jq/9nbLckW1amAb54Q==
X-Google-Smtp-Source: ABdhPJxq5q/aaT+6jdvgQQdbDwMNlvYfZjAmKD/2J/yR3c6DqBDMvry2T/Awy6EWGZ+THIsQHdyfhPbS801PyKVA3nE=
X-Received: by 2002:a05:6a00:b54:b029:207:2a04:7b05 with SMTP id
 p20-20020a056a000b54b02902072a047b05mr29651828pfo.12.1617103182535; Tue, 30
 Mar 2021 04:19:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210326203807.105754-1-lyude@redhat.com> <20210326203807.105754-21-lyude@redhat.com>
In-Reply-To: <20210326203807.105754-21-lyude@redhat.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 30 Mar 2021 13:19:31 +0200
Message-ID: <CAG3jFyvEvb=YWopYUmi1bf=fe3ZX7VmtvnnmT5dHcNjLhHvsQg@mail.gmail.com>
Subject: Re: [PATCH v2 20/20] drm/dp_mst: Convert drm_dp_mst_topology.c to drm_err()/drm_dbg*()
To:     Lyude Paul <lyude@redhat.com>
Cc:     nouveau@lists.freedesktop.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Lyude,

This patch looks good, but I have one question below. With it
addressed, feel free to add my r-b.

Reviewed-by: Robert Foss <robert.foss@linaro.org>

>
> -static bool drm_dp_sideband_parse_req(struct drm_dp_sideband_msg_rx *raw,
> +static bool drm_dp_sideband_parse_req(const struct drm_dp_mst_topology_mgr *mgr,
> +                                     struct drm_dp_sideband_msg_rx *raw,
>                                       struct drm_dp_sideband_msg_req_body *msg)
>  {
>         memset(msg, 0, sizeof(*msg));
> @@ -1117,12 +1125,12 @@ static bool drm_dp_sideband_parse_req(struct drm_dp_sideband_msg_rx *raw,
>
>         switch (msg->req_type) {
>         case DP_CONNECTION_STATUS_NOTIFY:
> -               return drm_dp_sideband_parse_connection_status_notify(raw, msg);
> +               return drm_dp_sideband_parse_connection_status_notify(mgr, raw, msg);
>         case DP_RESOURCE_STATUS_NOTIFY:
> -               return drm_dp_sideband_parse_resource_status_notify(raw, msg);
> +               return drm_dp_sideband_parse_resource_status_notify(mgr, raw, msg);
>         default:
> -               DRM_ERROR("Got unknown request 0x%02x (%s)\n", msg->req_type,
> -                         drm_dp_mst_req_type_str(msg->req_type));
> +               drm_err(mgr->dev, "Got unknown request 0x%02x (%s)\n",
> +                       msg->req_type, drm_dp_mst_req_type_str(msg->req_type));
>                 return false;
>         }
>  }
>

.. snip ..

> @@ -4118,12 +4121,12 @@ static int drm_dp_mst_handle_up_req(struct drm_dp_mst_topology_mgr *mgr)
>
>         INIT_LIST_HEAD(&up_req->next);
>
> -       drm_dp_sideband_parse_req(&mgr->up_req_recv, &up_req->msg);
> +       drm_dp_sideband_parse_req(mgr, &mgr->up_req_recv, &up_req->msg);

drm_dp_sideband_parse_req() is only called here, and the function
arguments could probably stand to have `&mgr->up_req_recv` removed
(here and in the func. declaration) since the same data structure is
accessible through the `mgr` pointer inside of
drm_dp_sideband_parse_req(). I guess this is a matter of taste, so
feel free to do what you want with this.

>
>         if (up_req->msg.req_type != DP_CONNECTION_STATUS_NOTIFY &&
>             up_req->msg.req_type != DP_RESOURCE_STATUS_NOTIFY) {
> -               DRM_DEBUG_KMS("Received unknown up req type, ignoring: %x\n",
> -                             up_req->msg.req_type);
> +               drm_dbg_kms(mgr->dev, "Received unknown up req type, ignoring: %x\n",
> +                           up_req->msg.req_type);
>                 kfree(up_req);
>                 goto out;
>         }
