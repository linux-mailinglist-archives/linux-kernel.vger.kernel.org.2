Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7FF3368D74
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 08:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240913AbhDWG6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 02:58:17 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33164 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhDWG6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 02:58:15 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id EFFDE1F437FB
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     Pi-Hsun Shih <pihsun@chromium.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH] platform/chrome: cros_usbpd_notify: Listen to EC_HOST_EVENT_USB_MUX host event
Date:   Fri, 23 Apr 2021 08:57:27 +0200
Message-Id: <161916102148.2605538.2186222563072187936.b4-ty@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210414064524.2450908-1-pihsun@chromium.org>
References: <20210414064524.2450908-1-pihsun@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Apr 2021 14:45:24 +0800, Pi-Hsun Shih wrote:
> On system that use ACPI, cros_usbpd_notify gets notifications of USB MUX
> host event same as PD host events [1]. But currently on system that use
> DT, the driver only listen on EC_HOST_EVENT_PD_MCU.
> 
> Add EC_HOST_EVENT_USB_MUX to the list of host events, so we have same
> behavior on all platforms.
> 
> [...]

Applied, thanks!

[1/1] platform/chrome: cros_usbpd_notify: Listen to EC_HOST_EVENT_USB_MUX host event
      commit: 4423ee65f76818c8a8994e6f5821372661ea7f89

Best regards,
-- 
Enric Balletbo i Serra <enric.balletbo@collabora.com>
