Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 157253F835E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 09:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240370AbhHZHwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 03:52:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:50856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240156AbhHZHwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 03:52:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0EDF960F4C;
        Thu, 26 Aug 2021 07:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629964303;
        bh=SEg9om1FKWwFDJHh8XU+728j7ziUxLBuq/tx3EMdVdA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ffnJf0ZEizMe+wlmYSSHMgDKbtroCWgwVwp1X+EqYZPl2bOCZkCYb4upvZOzDl+Kz
         GpHS0NQ0c+A/DiwDhvnVI9vefnM3Cci51uBfI6eBH/iQOywRjJjbq9ABs/DVAN+/oc
         9ma1dzKreWb5QpUbU7/QHEyI5kAAccjXZngUvY2zx//DHnWMbXlk22pynrPL0jgXsY
         taEZMxhePlyb/HcJYhjZMcTlofv5znivLssfEqhew5roz3zhO8mkWjjKmrgC/qpjnS
         ycUioVaDvbouWXtDkBztsq50EDaq8heANuXj3ulZQ8cDLqp2zMNzoLxyi77geYqrRp
         EBm+YIyEqEoSg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mJAAk-0007Pr-AU; Thu, 26 Aug 2021 09:51:39 +0200
Date:   Thu, 26 Aug 2021 09:51:38 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Utkarsh Verma <utkarshverma294@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH v2] USB: serial: Replace symbolic permissions by octal
 permissions
Message-ID: <YSdICms8vm4cmMzy@hovoldconsulting.com>
References: <YSYMXNvfjk0HdYr3@hovoldconsulting.com>
 <20210825162302.16243-1-utkarshverma294@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210825162302.16243-1-utkarshverma294@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 09:53:02PM +0530, Utkarsh Verma wrote:
> Replace symbolic permission macros with octal permission numbers
> because, octal permission numbers are easier to read and understand
> instead of their symbolic macro names.
> 
> No functional change.
> 
> Suggested-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Signed-off-by: Utkarsh Verma <utkarshverma294@gmail.com>

Thanks for the update. Now applied.

Johan
