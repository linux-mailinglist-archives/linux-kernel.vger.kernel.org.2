Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1813319ADE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 08:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbhBLHvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 02:51:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:46554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229690AbhBLHvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 02:51:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D5E8164DDA;
        Fri, 12 Feb 2021 07:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613116229;
        bh=YmKV2XkclwiTC7FGLygj4YhwivMeSQ8JzXw7psIIHNw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Er0Ag2IWZqry7zs/qZeF25qfoWTN5kG3Y+vTH5COkNbOXeXV9NPGzcK8WQHlRi6oe
         EfbRTaMdoBpT3HEznOSBFRhNKtms3Kfjet5F+VnVrmMatAuzktKATJYABKuyEj0HM3
         w2If8XyiEamDNXj/ItOYVjCjMJpKEb4BheZLFBSM=
Date:   Fri, 12 Feb 2021 08:50:26 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chanwoo Choi <cwchoi00@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>, chanwoo@kernel.org
Subject: Re: [GIT PULL v2] extcon next for v5.12
Message-ID: <YCYzQrMonj78Ut+x@kroah.com>
References: <CAGTfZH1o6zdN_42KJkVcA++QpSyY4_tMMFJSQFmWhKv7PWrghA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGTfZH1o6zdN_42KJkVcA++QpSyY4_tMMFJSQFmWhKv7PWrghA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 02:19:37PM +0900, Chanwoo Choi wrote:
> Dear Greg,
> 
> This is extcon-next pull request for v5.12. I add detailed description of
> this pull request on below. Please pull extcon with following updates.
> 
> Changes from v1:
> - Add missing committer information
> 
> Best Regards,
> Chanwoo Choi
> 
> 
> The following changes since commit 6ee1d745b7c9fd573fba142a2efdad76a9f1cb04:
> 
>   Linux 5.11-rc5 (2021-01-24 16:47:14 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git
> tags/extcon-next-for-5.12-v2
> 
> for you to fetch changes up to bd30a35764e136dc372e74c4856de633cb7ed8de:
> 
>   extcon: sm5502: Detect OTG when USB_ID is connected to ground
> (2021-02-10 08:15:28 +0900)
> 
> ----------------------------------------------------------------
> Krzysztof Kozlowski (1):
>       extcon: Add stubs for extcon_register_notifier_all() functions
> 
> Nikita Travkin (1):
>       extcon: sm5502: Detect OTG when USB_ID is connected to ground
> 
> Timon Baetz (1):
>       extcon: max8997: Add CHGINS and CHGRM interrupt handling

No diffstat???  How did you generate this pull request?

thanks,

greg k-h
