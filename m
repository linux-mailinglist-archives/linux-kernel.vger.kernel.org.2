Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA54E3D6E31
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 07:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235476AbhG0Ff4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 01:35:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:47496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234997AbhG0Ffa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 01:35:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 553D0610E5;
        Tue, 27 Jul 2021 05:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627364130;
        bh=QZn3Y/5lDoT1CB5x1bzBxI7iva5uev1ci/Z3NrJyvcQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ccFT+eHKP9bc15BaEMLa0POjMZRlzJJ/bNL6ZlM0iKkYA2E8+J4RecniBbiKJMcJt
         yO6L9yEahBpHTQyKj3ulr5lRfoWTq528otNILO+BEik6p5573scCcYY5hsxQFPtkiv
         EKEJighbKoKHmGImych7iaIwt8bDWRy17Hv1rsf8=
Date:   Tue, 27 Jul 2021 07:35:28 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     =?utf-8?B?dGNzX2tlcm5lbCjohb7orq/kupHlhoXmoLjlvIDlj5HogIUp?= 
        <tcs_kernel@tencent.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "yepeilin.cs@gmail.com" <yepeilin.cs@gmail.com>,
        "penguin-kernel@I-love.SAKURA.ne.jp" 
        <penguin-kernel@i-love.sakura.ne.jp>,
        "tzimmermann@suse.de" <tzimmermann@suse.de>,
        "george.kennedy@oracle.com" <george.kennedy@oracle.com>,
        "ducheng2@gmail.com" <ducheng2@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Internet]Re: [PATCH] fbcon: Out-Of-Bounds write in
 sys_imageblit, add range check
Message-ID: <YP+bINav7znIU6xF@kroah.com>
References: <D5DF8A1C-5FA2-426B-AAB4-3199AEA0A02E@tencent.com>
 <YP68cQ4WVVusCv0N@ravnborg.org>
 <28F2D8E8-B519-40F6-B6CD-98A0FAD67CD7@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <28F2D8E8-B519-40F6-B6CD-98A0FAD67CD7@tencent.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 01:53:13AM +0000, tcs_kernel(腾讯云内核开发者) wrote:
> yres and vyres can be controlled by user mode paramaters, and cause p->vrows to become a negative value. While this value be passed to real_y function, the ypos will be out of screen range.
> This is an out-of-bounds write bug.
> I think updatescrollmode is the right place to validate values supplied by a user ioctl, because only here makes --operation,and 0 is a legal value before that.

Please wrap your changelog text.

> 
> Signed-off-by: Tencent Cloud System tcs_kernel@tencent.com

That is not the name of a person :(

And the format isn't correct, so there's nothing we can do with this
patch, and the patch itself is corrupted and could not be applied :(

Also, what about checking these values earlier?  How can the value be 0
earlier and be acceptable?  Putting bounds on the user-provided values
would be much easier, right?

thanks,

greg k-h
