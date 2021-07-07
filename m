Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 911F73BE2D4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 07:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbhGGF4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 01:56:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:36616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230120AbhGGF4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 01:56:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D163561CB6;
        Wed,  7 Jul 2021 05:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1625637214;
        bh=KU7Lld3FrpURemteJNLQ8G3R5klJrF5KbTxbRQslhTc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kq7CbNLCgoNZ7nLNfBkUW4Uhot50Pm+EaQKiirdCzaK2Zunz5mHDSsukLcDHnIqnx
         6T+lG3H2UpNKBT1u59p3ujrf7crYWu2V6d4y96GKc8SBh8sv7PgcC+uxsxE/9UXhkF
         Zy2p6rJt62MMiNFIcyavChUag5NmJ3S9na5qsN2U=
Date:   Wed, 7 Jul 2021 07:53:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?utf-8?B?6LW15oyv5Zu9?= <zhenguo6858@gmail.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: n_gsm: delete SABM command frame as requester
Message-ID: <YOVBWuDDbd/eoeak@kroah.com>
References: <1625108078-16491-1-git-send-email-zhenguo6858@gmail.com>
 <695b2537-28e0-90c4-d516-727dfeead12d@kernel.org>
 <5cb496dc-eac1-124e-397d-0c58f5d4a7a1@kernel.org>
 <CAGGV+3+Oc415RJGueGHdYnDGWFqyuD_6ehBWybhR=6bDoFE9Wg@mail.gmail.com>
 <CAGGV+3J9Kj-GoiCBYNN=JLx=Jj02yMkpdg5E_+3W-tvQ_jESyQ@mail.gmail.com>
 <CAGGV+3JT6P=tM3_t045FfJtZQ_diPv2_qmnE1LHYvkQo7J7MAw@mail.gmail.com>
 <CAGGV+3LHqgpuvWC_WpkqYnk=U_1vaCReEMrYkenDSAi95740hQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGGV+3LHqgpuvWC_WpkqYnk=U_1vaCReEMrYkenDSAi95740hQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2021 at 01:31:41PM +0800, 赵振国 wrote:
> Dear Jiri,Greg

<snip>

Please do not send html email, it is rejected by the mailing lists so no
one else can see it to respond.

thanks,

greg k-h
