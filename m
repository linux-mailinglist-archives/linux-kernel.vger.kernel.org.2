Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9BEC44F41A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 17:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236019AbhKMQYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 11:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235980AbhKMQYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 11:24:42 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA73C061766
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 08:21:49 -0800 (PST)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1mlvmf-0001LT-Ji; Sat, 13 Nov 2021 17:21:41 +0100
Date:   Sat, 13 Nov 2021 17:21:41 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] staging: r8188eu: remove haldata's EEPROMVID / PID
Message-ID: <20211113162141.dpqbmkiqb3qxgjo7@viti.kaiser.cx>
References: <20211111212644.9011-1-martin@kaiser.cx>
 <6997531.xZuqOj027S@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6997531.xZuqOj027S@localhost.localdomain>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Fabio M. De Francesco (fmdefrancesco@gmail.com):

> On Thursday, November 11, 2021 10:26:38 PM CET Martin Kaiser wrote:

> > They are used only in a (disabled) debug print.

> > In practice, lsusb can be used to read the actual vid and pid.

> Hi Martin,

> You seem to have overlooked the usual rules for writing conformant commit 
> messages :)

> Please say "what" you did along with "why" you made the changes.

> Here, and in two or three other patches of your series, you forgot to 
> describe "what" you did. You actually wrote it in the "Subject" lines but, as 
> you know for sure, commit messages must be self-contained entities.

Hi Fabio,

thanks for the reminder. The commit message should indeed make sense
without the title.

> Also, it would be nice to have a cover letter and have all seven patches in 
> one thread in response to the above, even if it (AFAIK) is not strictly 
> required.

There wasn't a common topic in this series so I decided to add no cover
letter.

Best regards,
Martin
