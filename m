Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55405368D77
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 08:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240969AbhDWG6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 02:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240881AbhDWG6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 02:58:16 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B100CC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 23:57:40 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id E80911F437FE
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org,
        Prashant Malani <pmalani@chromium.org>
Cc:     Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Deepti Deshatty <deepti.deshatty@intel.com>,
        "Nikunj A . Dadhania" <nikunj.dadhania@intel.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: Track port role
Date:   Fri, 23 Apr 2021 08:57:29 +0200
Message-Id: <161916102147.2605538.4620946731286636751.b4-ty@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210420171008.3829549-1-pmalani@chromium.org>
References: <20210420171008.3829549-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Apr 2021 10:10:09 -0700, Prashant Malani wrote:
> Stash the currently reported port role in the port struct and add a
> check for that too while determining whether to re-configure on-board
> Type C switches (this deals with cases like role swaps where the mux
> flags don't change, but the port role does).

Applied, thanks!

[1/1] platform/chrome: cros_ec_typec: Track port role
      commit: 670160fea22c587b384d56698bbb661fa4801534

Best regards,
-- 
Enric Balletbo i Serra <enric.balletbo@collabora.com>
