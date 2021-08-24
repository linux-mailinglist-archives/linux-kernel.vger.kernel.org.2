Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6640A3F5F97
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 15:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237488AbhHXN4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 09:56:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:59904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234695AbhHXN4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 09:56:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD5EF610CD;
        Tue, 24 Aug 2021 13:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629813346;
        bh=/ITeM5nvvoLZZjLEwLX57QOTvSNZpPpjCey2QzxIFR8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h6I8HYm4yJrpUTDtyBeCbBe9E+sAFV6jkNQZEwBsi0GRDqcWgiVeGXQtiUIIp6PbB
         MlEmtLblZYHMUuPcBHGW6m0FFCLu+I0xBDcKgEwmVUK4jPpKeM8FBSY0Vc52eju0OU
         r6YOLJG7IKXiwTNx79l+B+Lc124p2veeCc6KlRxr+svDzxL/gaHe62GcsThRdERNVC
         3MWpMkcddhsLcFS+7BOLbfrp+DJWW5kwR15TwuRxKL2v8/kAt2ZKGvLdS5lkC5iw5R
         pHruu9YJqxc6A1KoE3U3ESaazh7m9A3Q4tf9JYXuVG3eQQvXcJVl6mnItVBZqFhvbR
         o0JAXQcCMzdcg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mIWtx-0007Pv-VK; Tue, 24 Aug 2021 15:55:42 +0200
Date:   Tue, 24 Aug 2021 15:55:41 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Utkarsh Verma <utkarshverma294@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] USB: serial: iuu_phoenix: Replace symbolic permissions
 by octal permissions
Message-ID: <YST6XZ/XJkTDm6rV@hovoldconsulting.com>
References: <20210820190306.18149-1-utkarshverma294@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210820190306.18149-1-utkarshverma294@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 21, 2021 at 12:33:06AM +0530, Utkarsh Verma wrote:
> This fixed the below checkpatch issue:
> WARNING: Symbolic permissions 'S_IRUGO | S_IWUSR' are not preferred.
> Consider using octal permissions '0644'.

Please do not run checkpatch.pl on code that's already in the tree. Use
it for your own patches before submitting them and always use your own
judgement when considering its suggestions.

This code does not need to be changed.

Johan
