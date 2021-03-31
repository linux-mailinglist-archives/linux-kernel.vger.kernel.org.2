Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2B334FA6F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 09:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbhCaHiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 03:38:16 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54042 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234086AbhCaHhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 03:37:53 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 637881F45429
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     Nathan Chancellor <nathan@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     clang-built-linux@googlegroups.com,
        Utkarsh Patel <utkarsh.h.patel@intel.com>,
        Guenter Roeck <groeck@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Azhar Shaikh <azhar.shaikh@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: fix clang -Wformat warning
Date:   Wed, 31 Mar 2021 09:37:42 +0200
Message-Id: <161717624818.4118309.17703664770897659047.b4-ty@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210322115602.4003221-1-arnd@kernel.org>
References: <20210322115602.4003221-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Mar 2021 12:55:55 +0100, Arnd Bergmann wrote:
> Clang warns about using the %h format modifier to truncate an
> integer:
> 
> drivers/platform/chrome/cros_ec_typec.c:1031:3: error: format specifies type 'unsigned char' but the argument has type 'unsigned int' [-Werror,-Wformat]
>                 typec->pd_ctrl_ver);
>                 ^~~~~~~~~~~~~~~~~~
> include/linux/dev_printk.h:131:47: note: expanded from macro 'dev_dbg'
>                 dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
>                                                     ~~~     ^~~~~~~~~~~
> 
> [...]

Applied, thanks!

[1/1] platform/chrome: cros_ec_typec: fix clang -Wformat warning
      commit: c6e939c63c80c26460b25cf1150ebe8396e8adcf

Best regards,
-- 
Enric Balletbo i Serra <enric.balletbo@collabora.com>
