Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C00373BE2F2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 08:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbhGGGMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 02:12:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:38714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230226AbhGGGMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 02:12:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF5B0619A5;
        Wed,  7 Jul 2021 06:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1625638209;
        bh=GP/KNmt2MWrvtbsyuIqX2zUciCZcl+mga4IdowyZzEg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0L6C1Tmxl9Mmzaw52LXFamjtvjsPmhzSeiQ7/oOWuZkBoQyNce18p+5CHNmN8ENoH
         xNfEP+lu+UCgRWHdzR2egrnQpULL7w1fAzrrzGassXGXk7wsG51btr+lEHc4SMMWWW
         tIEsNH3kKqWmPeua7zTmw6ZdlXz5j1cmE8MXgp/I=
Date:   Wed, 7 Jul 2021 08:10:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?utf-8?B?6LW15oyv5Zu9?= <zhenguo6858@gmail.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tty: n_gsm: CR bit value should be 0 when config
 "initiator=0"
Message-ID: <YOVFPU27hhYubAQl@kroah.com>
References: <1623844402-4731-1-git-send-email-zhenguo6858@gmail.com>
 <CAGGV+3LgLdohhYhH+qJTokeNU_WdV9oRNHMc9a_5YTTVA3U8ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGGV+3LgLdohhYhH+qJTokeNU_WdV9oRNHMc9a_5YTTVA3U8ow@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2021 at 02:02:54PM +0800, 赵振国 wrote:
> Dear Jiri,Greg

<snip>

still html :(

Please fix your email client, there are instructions on how to do that
in the Documentation/ directory.

greg k-h
