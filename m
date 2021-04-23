Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79052368D7A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 08:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241040AbhDWG61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 02:58:27 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33190 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240910AbhDWG6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 02:58:17 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 8BC4C1F437FB
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     Benson Leung <bleung@chromium.org>, Ye Bin <yebin10@huawei.com>
Cc:     linux-kernel@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] platform/chrome: cros_ec_lpc: Use DEFINE_MUTEX() for mutex lock
Date:   Fri, 23 Apr 2021 08:57:31 +0200
Message-Id: <161916102148.2605538.6249402321169381536.b4-ty@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210409095138.2293869-1-yebin10@huawei.com>
References: <20210409095138.2293869-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Apr 2021 17:51:38 +0800, Ye Bin wrote:
> mutex lock can be initialized automatically with DEFINE_MUTEX()
> rather than explicitly calling mutex_init().

Applied, thanks!

[1/1] platform/chrome: cros_ec_lpc: Use DEFINE_MUTEX() for mutex lock
      commit: d61b3f9b91be32f714b218377ab5081932e3ebc2

Best regards,
-- 
Enric Balletbo i Serra <enric.balletbo@collabora.com>
