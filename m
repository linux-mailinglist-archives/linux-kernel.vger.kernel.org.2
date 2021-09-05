Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47E9940113C
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 20:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236214AbhIESwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 14:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbhIESwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 14:52:20 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EB6C061575
        for <linux-kernel@vger.kernel.org>; Sun,  5 Sep 2021 11:51:16 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id t13so1507258vkm.4
        for <linux-kernel@vger.kernel.org>; Sun, 05 Sep 2021 11:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=OFhp5qOgHpAi603N0nela2D85qEGVdFHkGLbavWDR6w=;
        b=Tn4yoeJXDQw2MDPyO5z0Pll4WYHKB9sTqXQ5s5dsFJ7CMLurgNRWfNQs9ez5KxmwEd
         hcm2va+WW9xNJy8ae/POty5VIqq8ZnM/LT7PlN34iSXsh25CUw0OPD+lKiHTn2J/0yPz
         gqUpy3kXEWZ81n+1JepzH3iovBITzmo0gaMtd2/WbJ9NobKx8kiUP+NRsmXVCJImKc+F
         WX+L1w9/JbAo+Al/KBJY4UK//84VPYNV4aI+ZjrH8YXbjMhTzToW6DvQDyA3hNyF1eWL
         rU0SgrQ2F9EtULcTk8TLE9YENUH7RKI6/XpGk861gYAFO/SdLmAn1UvwsTeG4t/cRPTF
         3Cng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=OFhp5qOgHpAi603N0nela2D85qEGVdFHkGLbavWDR6w=;
        b=HPdk/bnQeGuZoW0hZiP4gwQYFrlyfkwHjWmoW/F4+4ESF3mVhvI03jz5FneeCQgoW7
         2y49zFRXr4Aq6sA2PL4R3rsTFr7sYULGQ6L4he7bFBrHK3yMhIjROn5JVmyYe3SK7Lji
         aA7USbvx8OF0+560ad2EzsCYik+R3r5RmzjQTMA66ys071Q/GjvyedkigveVTEY0GZm5
         lXeRhj/GrnyZxB9zC2mug8v0VkhvjnXjdXuKuy56o6PTBSd/7iG1qySlT3kHUSzKzYR9
         iho1q2hBsBRlu0uIOdmWNlp86NDQ7oKEWLnxBUTrRZnVdn+w8nFA/FexbqhzJToTw5p3
         xRXg==
X-Gm-Message-State: AOAM530q9QmHI7UDoiyuYL8HprKeaZLJzsmzxNU6Li1657x2+dd4Vq6T
        GuUyEhnzu9MY0sQj4URoi6mnOjoKjj9InqvwhnzqR8D6X8Y=
X-Google-Smtp-Source: ABdhPJwe5mYz8Qo5C8x6jThg2xR12TyzrY7uSlQtxgco4MVzuWlwZ2fvpqc12r6MAaX62HtYq+ZcTG81lVmZXibfAFg=
X-Received: by 2002:a1f:9e85:: with SMTP id h127mr1010337vke.22.1630867875366;
 Sun, 05 Sep 2021 11:51:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210831202133.2165222-1-jim.cromie@gmail.com> <20210831202133.2165222-7-jim.cromie@gmail.com>
In-Reply-To: <20210831202133.2165222-7-jim.cromie@gmail.com>
From:   jim.cromie@gmail.com
Date:   Sun, 5 Sep 2021 12:50:48 -0600
Message-ID: <CAJfuBxwqdy888_v7a6U5BYPZxDkQAB4SLPdFyEv+MW98ByNuQg@mail.gmail.com>
Subject: Re: [PATCH v7 6/8] drm_print: instrument drm_debug_enabled
To:     Jason Baron <jbaron@akamai.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        intel-gvt-dev@lists.freedesktop.org,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2021 at 2:21 PM Jim Cromie <jim.cromie@gmail.com> wrote:
>
> Duplicate drm_debug_enabled() code into both "basic" and "dyndbg"
> ifdef branches.  Then add a pr_debug("todo: ...") into the "dyndbg"
> branch.
>
> Then convert the "dyndbg" branch's code to a macro, so that its
> pr_debug() get its callsite info from the invoking function, instead
> of from drm_debug_enabled() itself.
>
> This gives us unique callsite info for the 8 remaining users of
> drm_debug_enabled(), and lets us enable them individually to see how
> much logging traffic they generate.  The oft-visited callsites can
> then be reviewed for runtime cost and possible optimizations.
>
> Heres what we get:
>
> bash-5.1# modprobe drm
> dyndbg: 384 debug prints in module drm
> bash-5.1# grep todo: /proc/dynamic_debug/control
> drivers/gpu/drm/drm_edid.c:1843 [drm]connector_bad_edid =_ "todo: maybe avoid via dyndbg\012"
> drivers/gpu/drm/drm_print.c:309 [drm]___drm_dbg =p "todo: maybe avoid via dyndbg\012"
> drivers/gpu/drm/drm_print.c:286 [drm]__drm_dev_dbg =p "todo: maybe avoid via dyndbg\012"
> drivers/gpu/drm/drm_vblank.c:1491 [drm]drm_vblank_restore =_ "todo: maybe avoid via dyndbg\012"
> drivers/gpu/drm/drm_vblank.c:787 [drm]drm_crtc_vblank_helper_get_vblank_timestamp_internal =_ "todo: maybe avoid via dyndbg\012"
> drivers/gpu/drm/drm_vblank.c:410 [drm]drm_crtc_accurate_vblank_count =_ "todo: maybe avoid via dyndbg\012"
> drivers/gpu/drm/drm_atomic_uapi.c:1457 [drm]drm_mode_atomic_ioctl =_ "todo: maybe avoid via dyndbg\012"
> drivers/gpu/drm/drm_edid_load.c:178 [drm]edid_load =_ "todo: maybe avoid via dyndbg\012"
>
> At quick glance, edid won't qualify, drm_print might, drm_vblank is
> strongest chance, maybe atomic-ioctl too.
>
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> ---

heres 120 seconds of enabled todos, from this patch

[jimc@frodo wk-next]$ journalctl -b0 | grep todo | grep 'frodo kernel'
[jimc@frodo wk-next]$ sudo su -c 'echo format ^todo: +pfml >
/proc/dynamic_debug/control;  sleep 120; echo format ^todo: -p >
/proc/dynamic_debug/control'
[sudo] password for jimc:
[jimc@frodo wk-next]$ journalctl -b0 | grep todo | grep 'frodo kernel'
 > todo-120-log
[jimc@frodo wk-next]$ wc todo-120-log
  228  2516 24066 todo-120-log

so overall thats not too much work, not so many bitchecks as to be
worth avoiding.

I think I'll try hitting it with my new igt-tools hammer, see what breaks :-)


[jimc@frodo wk-next]$ hsto todo-120-log
120 :  drm:drm_crtc_vblank_helper_get_vblank_timestamp_internal:787:
todo: maybe avoid via dyndbg
40 :  i915:process_csb:1904: todo: maybe avoid via dyndbg
20 :  drm:drm_vblank_restore:1491: todo: maybe avoid via dyndbg
20 :  drm:drm_crtc_accurate_vblank_count:410: todo: maybe avoid via dyndbg
20 :  i915:skl_print_wm_changes:6068: todo: maybe avoid via dyndbg
2 :  dyndbg: applied: func="" file="" module="" format="^todo:" lineno=0-0
2 :  dyndbg: parsed: func="" file="" module="" format="^todo:" lineno=0-0
1 :  dyndbg: split into words: "format" "^todo:" "-p"
1 :  dyndbg: split into words: "format" "^todo:" "+pfml"
1 :  dyndbg: query 0: "format ^todo: -p" mod:*
1 :  dyndbg: query 0: "format ^todo: +pfml" mod:*
