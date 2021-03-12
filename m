Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A453339351
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 17:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbhCLQ1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 11:27:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:42616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232283AbhCLQ0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 11:26:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 932B86500B;
        Fri, 12 Mar 2021 16:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615566414;
        bh=KSiQ1s8ZuHjLGWp0+JCP/KJhwUsy63GiBUc7iZoOfuk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sY4mq3Op3zvgsXCstkSq9ZjnK9nXV8W3H/IJPeYuoKC6/aQAkwimgSwFIa6lPZV47
         nlhAoukF5s3FYcn+/9iPZiwFxvmSCSCOm0i1rQ/OM2IX1O5eDkuAJkFBOyuftn0w8X
         CNM0F1UGEBdmfVbLz4rQLz7leREPoMMprgYyeXO4=
Date:   Fri, 12 Mar 2021 17:26:51 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Longji Guo <guolongji@uniontech.com>
Cc:     ross.schm.dev@gmail.com, matthew.v.deangelis@gmail.com,
        dan.carpenter@oracle.com, amarjargal16@gmail.com, vkor@vkten.in,
        pterjan@google.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: rtl8723bs/core: fix coding style issue
Message-ID: <YEuWS12qAiXS+enC@kroah.com>
References: <20210310113503.1352-1-guolongji@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310113503.1352-1-guolongji@uniontech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 07:35:03PM +0800, Longji Guo wrote:
> Move operators and spaces before tabs to fix coding style issues.

This change doesn't have anything to do with tabs.

confused,

greg k-h
