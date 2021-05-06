Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99446375929
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 19:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236240AbhEFRYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 13:24:37 -0400
Received: from srv6.fidu.org ([159.69.62.71]:57720 "EHLO srv6.fidu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236042AbhEFRYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 13:24:34 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id BF278C800AE;
        Thu,  6 May 2021 19:23:34 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id GWKsiSSuUWHl; Thu,  6 May 2021 19:23:34 +0200 (CEST)
Received: from wsembach-tuxedo.fritz.box (p200300e37F12f2008bdED9a70B37E3f5.dip0.t-ipconnect.de [IPv6:2003:e3:7f12:f200:8bde:d9a7:b37:e3f5])
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPA id 57D0FC800AB;
        Thu,  6 May 2021 19:23:34 +0200 (CEST)
From:   Werner Sembach <wse@tuxedocomputers.com>
To:     ville.syrjala@linux.intel.com, airlied@linux.ie, daniel@ffwll.ch,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] drm/i915/display: Try YCbCr420 color when RGB fails
Date:   Thu,  6 May 2021 19:23:22 +0200
Message-Id: <20210506172325.1995964-1-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When encoder validation of a display mode fails, retry with less bandwidth
heavy YCbCr420 color mode, if available. This enables some HDMI 1.4 setups
to support 4k60Hz output, which previously failed silently.

AMDGPU had nearly the exact same issue. This problem description is
therefore copied from my commit message of the AMDGPU patch.

On some setups, while the monitor and the gpu support display modes with
pixel clocks of up to 600MHz, the link encoder might not. This prevents
YCbCr444 and RGB encoding for 4k60Hz, but YCbCr420 encoding might still be
possible. However, which color mode is used is decided before the link
encoder capabilities are checked. This patch fixes the problem by retrying
to find a display mode with YCbCr420 enforced and using it, if it is
valid.

This patchset is revision 5. Only change to 4 is a small whitespace error fix.
Resend because automation tools did not work with wrong e-mail format used
before.

