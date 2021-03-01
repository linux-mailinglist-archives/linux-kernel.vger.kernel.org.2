Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 287E9327A8C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 10:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233816AbhCAJQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 04:16:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:41884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233805AbhCAJPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 04:15:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2388E64E01;
        Mon,  1 Mar 2021 09:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614590115;
        bh=Gxy6eb50XNaXKzNUP2NQegiVRKS+Z5pjHiovZxYsuz4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nVFbQJ+cWFQmBlgb2ZLBsWusafPjYu2XU3657soKOHm5jVWPRUzhk9AYG+fVgVMSU
         q3yxJEOMwqOvlOnCFjFNQeUzMe7m48tmBdYFJPd/UBP3TkKsJfYuL6CxnJV6oiK2Km
         QRr3Jushb3y+RHKOIhEXY/DCvf+SyZ2nLZYZXObahSt9+Ry9elZyvvC7BtZ/sEk3Kf
         42gcj9xWJibmD2LseuRbrA6mu+H1WxWKsep9ERHO4uf9kQE3Weksjkfvp+42Dd1Hmo
         +1nsI1Kwhv9dBusQZsfJ3V936/nuj/xZ/thZtxb7ckH1662CSaAJwin6DkdNItc5W1
         M0dyGAna5gD8A==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lGeeK-0006w5-Hz; Mon, 01 Mar 2021 10:15:32 +0100
Date:   Mon, 1 Mar 2021 10:15:32 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH] USB: serial: cp210x: add some more GE USB IDs
Message-ID: <YDywtJBTmyR1vjFm@hovoldconsulting.com>
References: <20210223164418.118135-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210223164418.118135-1-sebastian.reichel@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 05:44:18PM +0100, Sebastian Reichel wrote:
> GE CS1000 has some more custom USB IDs for CP2102N; add them
> to the driver to have working auto-probing.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Now applied, thanks.

Johan
