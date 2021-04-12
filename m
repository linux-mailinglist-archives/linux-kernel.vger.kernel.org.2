Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D803D35CE82
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 18:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344235AbhDLQpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 12:45:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60477 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244184AbhDLQck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 12:32:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618245141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=KLSeyjnN+Nc0bGTYt65N2Vzxd1h3fZ8Uio7k1E2dBH0=;
        b=hpVCzwXxsbwjvaKILYEQ8foI3GouSOMJwar4LNwkZ2Nm2i3IepJbCra5l95TXcdzoJ4jaO
        EfL+BDvc1W6dpllaBHRaYecH246bHHq+rs8id7dETjqahBbCyMJtLOVY22zgHrFqmGh9/S
        vISCUfK32QIU8+F3l/oubwdfEC4Ffk0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-rzmZgZcxOXKp6oDTt5Yv7Q-1; Mon, 12 Apr 2021 12:32:17 -0400
X-MC-Unique: rzmZgZcxOXKp6oDTt5Yv7Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D972F6D241;
        Mon, 12 Apr 2021 16:32:15 +0000 (UTC)
Received: from omen (ovpn-117-254.rdu2.redhat.com [10.10.117.254])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 13A0010023AB;
        Mon, 12 Apr 2021 16:32:14 +0000 (UTC)
Date:   Mon, 12 Apr 2021 10:32:14 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     zhenyuw@linux.intel.com, zhi.a.wang@intel.com
Cc:     intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, <linux-kernel@vger.kernel.org>
Subject: Regression: gvt: vgpu 1: MI_LOAD_REGISTER_MEM handler error
Message-ID: <20210412103214.337d521a@omen>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Running a Windows guest on a i915-GVTg_V4_2 from an HD 5500 IGD on
v5.12-rc6 results in host logs:

gvt: vgpu 1: lrm access to register (20c0)
gvt: vgpu 1: MI_LOAD_REGISTER_MEM handler error
gvt: vgpu 1: cmd parser error
0x0 
0x29 

gvt: vgpu 1: scan wa ctx error
gvt: vgpu 1: failed to submit desc 0
gvt: vgpu 1: fail submit workload on ring rcs0
gvt: vgpu 1: fail to emulate MMIO write 00002230 len 4

The guest goes into a boot loop triggering this error before reaching
the desktop and rebooting.  Guest using Intel driver 20.19.15.5171
dated 11/4/2020 (from driver file 15.40.5171).

This VM works well with the same guest and userspace software stack on
Fedora's kernel 5.11.11-200.fc33.x86_64.  Thanks,

Alex

