Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69E2137C0D8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 16:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbhELOyh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 12 May 2021 10:54:37 -0400
Received: from srv6.fidu.org ([159.69.62.71]:44352 "EHLO srv6.fidu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231636AbhELOyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 10:54:14 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id 09121C800DD;
        Wed, 12 May 2021 16:53:05 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id lGM8HwLdan0L; Wed, 12 May 2021 16:53:04 +0200 (CEST)
Received: from [IPv6:2003:e3:7f15:cc00:73bb:e3c1:c946:13a6] (p200300E37f15CC0073bBe3c1c94613a6.dip0.t-ipconnect.de [IPv6:2003:e3:7f15:cc00:73bb:e3c1:c946:13a6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPSA id 918EDC800D9;
        Wed, 12 May 2021 16:53:04 +0200 (CEST)
From:   Werner Sembach <wse@tuxedocomputers.com>
To:     Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        intel-gfx@lists.freedesktop.org,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        emil.l.velikov@gmail.com
References: <8c0d7ad8-7ade-bf8a-0414-cc795fbb6aa2@tuxedocomputers.com>
Subject: Re: New uAPI for color management proposal and feedback request
Message-ID: <7fdd5404-9f55-9d54-524b-10364c1f4f2d@tuxedocomputers.com>
Date:   Wed, 12 May 2021 16:53:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <8c0d7ad8-7ade-bf8a-0414-cc795fbb6aa2@tuxedocomputers.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 12.05.21 um 14:06 schrieb Werner Sembach:

> Hello,
>
> In addition to the existing "max bpc", and "Broadcast RGB/output_csc" drm properties I propose 4 new properties:
> "preferred pixel encoding", "active color depth", "active color range", and "active pixel encoding"
>
>
> Motivation:
>
> Current monitors have a variety pixel encodings available: RGB, YCbCr 4:4:4, YCbCr 4:2:2, YCbCr 4:2:0.
>
> In addition they might be full or limited RGB range and the monitors accept different bit depths.
>
> Currently the kernel driver for AMD and Intel GPUs automatically configure the color settings automatically with little
> to no influence of the user. However there are several real world scenarios where the user might disagree with the
> default chosen by the drivers and wants to set his or her own preference.
>
> Some examples:
>
> 1. While RGB and YCbCr 4:4:4 in theory carry the same amount of color information, some screens might look better on one
> than the other because of bad internal conversion. The driver currently however has a fixed default that is chosen if
> available (RGB for Intel and YCbCr 4:4:4 for AMD). The only way to change this currently is by editing and overloading
> the edid reported by the monitor to the kernel.
>
> 2. RGB and YCbCr 4:4:4 need a higher port clock then YCbCr 4:2:0. Some hardware might report that it supports the higher
> port clock, but because of bad shielding on the PC, the cable, or the monitor the screen cuts out every few seconds when
> RGB or YCbCr 4:4:4 encoding is used, while YCbCr 4:2:0 might just work fine without changing hardware. The drivers
> currently however always default to the "best available" option even if it might be broken.
>
> 3. Some screens natively only supporting 8-bit color, simulate 10-Bit color by rapidly switching between 2 adjacent
> colors. They advertise themselves to the kernel as 10-bit monitors but the user might not like the "fake" 10-bit effect
> and prefer running at the native 8-bit per color.
>
> 4. Some screens are falsely classified as full RGB range wile they actually use limited RGB range. This results in
> washed out colors in dark and bright scenes. A user override can be helpful to manually fix this issue when it occurs.
>
> There already exist several requests, discussion, and patches regarding the thematic:
>
> - https://gitlab.freedesktop.org/drm/amd/-/issues/476
>
> - https://gitlab.freedesktop.org/drm/amd/-/issues/1548
>
> - https://lkml.org/lkml/2021/5/7/695
>
> - https://lkml.org/lkml/2021/5/11/416
>
>
> Current State:
>
> I only know bits about the Intel i915 and AMD amdgpu driver. I don't know how other driver handle color management
>
> - "max bpc", global setting applied by both i915 (only on dp i think?) and amdgpu. Default value is "8". For every
> resolution + frequency combination the highest possible even number between 6 and max_bpc is chosen. If the range
> doesn't contain a valid mode the resolution + frequency combination is discarded (but I guess that would be a very
> special edge case, if existent at all, when 6 doesn't work but 10 would work). Intel HDMI code always checks 8, 12, and
> 10 and does not check the max_bpc setting.
>
> - "Broadcast RGB" for i915 and "output_csc" for the old radeon driver (not amdgpu), overwrites the kernel chosen color
> range setting (full or limited). If I recall correctly Intel HDMI code defaults to full unless this property is set,
> Intel dp code tries to probe the monitor to find out what to use. amdgpu has no corresponding setting (I don't know how
> it's decided there).
>
> - RGB pixel encoding can be forced by overloading a Monitors edid with one that tells the kernel that only RGB is
> possible. That doesn't work for YCbCr 4:4:4 however because of the edid specification. Forcing YCbCr 4:2:0 would
> theoretically also be possible this way. amdgpu has a debugfs switch "force_ycbcr_420" which makes the driver default to
> YCbCr 4:2:0 on all monitors if possible.
>
>
> Proposed Solution:
>
> 1. Add a new uAPI property "preferred pixel encoding", as a per port setting.
>
>     - An amdgpu specific implementation was already shared here: https://gitlab.freedesktop.org/drm/amd/-/issues/476
>
>     - It also writes back the actually used encoding if the one requested was not possible, overwriting the requested
> value in the process. I think it would be better to have this feedback channel as a different, read-only property.
>
>     - Make this solution vendor agnostic by putting it in the drm_connector_state struct next do max_bpc
> https://elixir.bootlin.com/linux/v5.13-rc1/source/include/drm/drm_connector.h#L654 and add patches to amdgpu and i915 to
> respect this setting
>
> 2. Convert "Broadcast RGB" to a vendor agnostic setting/replace with a vendor agnostic setting.
>
>     - Imho the name is not very fitting, but it pops up in many tutorials throughout the web (some other opinions? how
> could a rename be handled?".
>
>     - Also move it from Intel specific structs to the drm_connector_state struct (please let me know if there is a
> better place)
>
> 3. Strive for full implementation of "max bpc"
>
>     - I need to double check the Intel HDMI code.
>
> 4. Add 3 feedback channels "active color depth", "active color range", and "active pixel encoding" as vendor agnostic
> settings in the drm_connector_state struct
>
>     - Possible values are:
>
>         - unknown, undefined, 6-bit, 8-bit, 9-bit, 10-bit, 11-bit, 12-bit, 14-bit, 16-bit (alternatively: an integer
> from -1 (unknown), 0 (undefined) to 16, let me know what would be more suitable)
>
>         - unknown, undefined, full, limited
>
>         - unknown, undefined, rgb, ycbcr444, ycbcr422, ycbcr420
>
>     - it's the responsibility of the driver to update the values once the port configuration changes
>
>     - if the driver does not support the feedback channels they are set to unknown
>
>     - if the driver uses a non listed setting it should set the property to undefined
>
>     - A more detailed description why I think these feedback channel are important and should be their own read-only
> property can be found here: https://lkml.org/lkml/2021/5/11/339
>
>
> Adoption:
>
> A KDE dev wants to implement the settings in the KDE settings GUI:
> https://gitlab.freedesktop.org/drm/amd/-/issues/476#note_912370
>
> Tuxedo Computers (my employer) wants to implement the settings desktop environment agnostic in Tuxedo Control Center. I
> will start work on this in parallel to implementing the new kernel code.
>
>
> Questions:
>
> I'm very curious about feedback from the dri-devel community. Would the concept outlaid above be accepted as new uAPI
> once it's fully implemented?
>
> Where would be the best way to store the new vendor agnostic settings? Following the implementation of max_bpc i would
> put it in the drm_connector_state struct.
>
> My way forward would be to implement the feedback channels first, because they can be very useful for debugging the
> setting properties afterwards. I will split each of it up it in 3 or 5 patch sets: 1 for the vendor agnostic part, 1 for
> Intel (or 2 split up between HDMI and DP), and 1 for AMD (or 2 split up between HDMI and DP)
>
> Kind regards,
>
> Werner Sembach
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
I found this: https://dri.freedesktop.org/docs/drm/gpu/todo.html#consolidate-custom-driver-modeset-properties as an
additional reference. (Thanks @emersion in https://github.com/swaywm/wlroots/pull/2310)

