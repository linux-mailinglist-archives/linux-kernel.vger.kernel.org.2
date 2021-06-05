Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B299739C76A
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 12:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhFEK2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 06:28:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:44584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229902AbhFEK2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 06:28:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A1C5A613D8;
        Sat,  5 Jun 2021 10:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622888823;
        bh=YioKZDxufSEZE3P4aTZ9DMtkP6Zo6Hey96e+OoMhoro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=auQvtFtAysLkdD/b3mhz7wZtSilohlTDynB4JzfHDWlnfELjqW7eAzmem7BckHsuL
         OnA1z2gk3T1fD4BsgZ/W51WgNG1DMuxBjKlHBfup7dTM4Uo1hR79sHEpbTOU9/VaPs
         ehdtvp+qZPULNM6MtUpRGuEWT8Nlg43BpULp9no6gHdWD64shIe/Zj2OF4tiNlDZFx
         kAVSTjnuXM/7voXFbaoc2540CJJnMJpbWhygN1PoHlwKSdK5E4ZMmvy4s8oQNCzvMk
         jLig1LPbN/sj6pXxyRhOtQ/2oA5jw8BISB3LqhWLOfMpegWBkbUzrpR1dyWLXNBZc4
         JHTtbV0prvQSw==
Received: from johan by xi with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1lpTW8-0007Wd-O3; Sat, 05 Jun 2021 12:27:00 +0200
Date:   Sat, 5 Jun 2021 12:27:00 +0200
From:   Johan Hovold <johan@kernel.org>
To:     George McCollister <george.mccollister@gmail.com>
Cc:     linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: ftdi_sio: add NovaTech OrionMX product ID
Message-ID: <YLtRdEz8wwbGUvLi@hovoldconsulting.com>
References: <20210604003208.31799-1-george.mccollister@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604003208.31799-1-george.mccollister@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2021 at 07:32:08PM -0500, George McCollister wrote:
> Add PID for the NovaTech OrionMX so it can be automatically detected.
> 
> Signed-off-by: George McCollister <george.mccollister@gmail.com>

Now applied, thanks.

Johan
