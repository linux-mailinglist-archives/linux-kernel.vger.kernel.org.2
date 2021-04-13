Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 447CB35D4C6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 03:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244785AbhDMBYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 21:24:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22323 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240522AbhDMBYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 21:24:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618277036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vdb72vFtidwPinNRFHvros4PP2idQiBFZaTUwAj2cuc=;
        b=ItXNkXMjmEdPJ+dxOrMRliCk3jbvRO2+KCHmwwEYUpwLUykIjFlqU7sRZCJq4RCOXs/eZg
        lruSBEewYnNT/G7glBVREIujX7a7/iHJKMyLSjTQxlPsHc4HQ7r4cs9hidWWD5Se9byQGS
        uBUQGY8I+gzTAYxxwzBBlIqLI5nFKf4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-Z9JJU6_uN_KDYxPT0Ueucw-1; Mon, 12 Apr 2021 21:23:50 -0400
X-MC-Unique: Z9JJU6_uN_KDYxPT0Ueucw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 745D18030A1;
        Tue, 13 Apr 2021 01:23:49 +0000 (UTC)
Received: from x1.home.shazbot.org (ovpn-117-254.rdu2.redhat.com [10.10.117.254])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2442F6F13B;
        Tue, 13 Apr 2021 01:23:47 +0000 (UTC)
Date:   Mon, 12 Apr 2021 19:23:47 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     zhenyuw@linux.intel.com, zhi.a.wang@intel.com
Cc:     intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, <linux-kernel@vger.kernel.org>,
        yan.y.zhao@intel.com
Subject: Re: Regression: gvt: vgpu 1: MI_LOAD_REGISTER_MEM handler error
Message-ID: <20210412192347.042fbc14@x1.home.shazbot.org>
In-Reply-To: <20210412103214.337d521a@omen>
References: <20210412103214.337d521a@omen>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Apr 2021 10:32:14 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> Running a Windows guest on a i915-GVTg_V4_2 from an HD 5500 IGD on
> v5.12-rc6 results in host logs:
> 
> gvt: vgpu 1: lrm access to register (20c0)
> gvt: vgpu 1: MI_LOAD_REGISTER_MEM handler error
> gvt: vgpu 1: cmd parser error
> 0x0 
> 0x29 
> 
> gvt: vgpu 1: scan wa ctx error
> gvt: vgpu 1: failed to submit desc 0
> gvt: vgpu 1: fail submit workload on ring rcs0
> gvt: vgpu 1: fail to emulate MMIO write 00002230 len 4
> 
> The guest goes into a boot loop triggering this error before reaching
> the desktop and rebooting.  Guest using Intel driver 20.19.15.5171
> dated 11/4/2020 (from driver file 15.40.5171).
> 
> This VM works well with the same guest and userspace software stack on
> Fedora's kernel 5.11.11-200.fc33.x86_64.  Thanks,

Bisected to:

commit f18d417a57438498e0de481d3a0bc900c2b0e057
Author: Yan Zhao <yan.y.zhao@intel.com>
Date:   Wed Dec 23 11:45:08 2020 +0800

    drm/i915/gvt: filter cmds "srm" and "lrm" in cmd_handler
    
    do not allow "srm" and "lrm" except for GEN8_L3SQCREG4 and 0x21f0.
    
    Cc: Colin Xu <colin.xu@intel.com>
    Cc: Kevin Tian <kevin.tian@intel.com>
    Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
    Signed-off-by: Zhenyu Wang <zhenyuw@linux.intel.com>
    Link: http://patchwork.freedesktop.org/patch/msgid/20201223034508.17031-1-yan.y.zhao@intel.com
    Reviewed-by: Zhenyu Wang <zhenyuw@linux.intel.com>

