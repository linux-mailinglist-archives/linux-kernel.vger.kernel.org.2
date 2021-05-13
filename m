Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2D7137F9DA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 16:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234640AbhEMOm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 10:42:56 -0400
Received: from netrider.rowland.org ([192.131.102.5]:55733 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S234619AbhEMOmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 10:42:46 -0400
Received: (qmail 968921 invoked by uid 1000); 13 May 2021 10:41:36 -0400
Date:   Thu, 13 May 2021 10:41:36 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Chris Chiu <chris.chiu@canonical.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, m.v.b@runbox.com,
        hadess@hadess.net, linux-usb@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] USB: reset-resume the device when PORT_SUSPEND is
 set but timeout
Message-ID: <20210513144136.GF967812@rowland.harvard.edu>
References: <20210510145030.1495-1-chris.chiu@canonical.com>
 <20210510145030.1495-2-chris.chiu@canonical.com>
 <20210510150203.GD863718@rowland.harvard.edu>
 <CABTNMG24BOS_+uGEYFLJrmEW10eTGjrOowwS7Zb_U+AvkZWTyQ@mail.gmail.com>
 <20210511163026.GA901897@rowland.harvard.edu>
 <CABTNMG2OiEFzMwMaUaVL9B6Om87e9qQMFBXRKej7G6zuvBXW=w@mail.gmail.com>
 <20210512150424.GA934575@rowland.harvard.edu>
 <CABTNMG0Skqim9UOMqNuaO94iL+Ff6Eu47itmv0RFTwY4xYWhGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABTNMG0Skqim9UOMqNuaO94iL+Ff6Eu47itmv0RFTwY4xYWhGQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 12:21:52PM +0800, Chris Chiu wrote:
> On Wed, May 12, 2021 at 11:04 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > For testing purposes, set status to 0 and jump to a new goto label in
> > the "else" branch.  In other words, treat it as if the suspend really
> > had worked and go back to the successful pathway.  Try this out and see
> > if it fixes the problem.
> >
> > If it does then the reset-resume isn't needed.  If it doesn't, post your
> > patch again, and mention in the patch description that testing shows the
> > reset-resume really is necessary.
> >
> > Alan Stern
> 
> Thanks for the suggestion. I revised the patch to create a new goto
> label in the "else" branch and clear the status to zero if the port is
> really suspended. It fixed the problem in my 100 time suspend/resume
> test. I will send v3 patch w/ the modification.

Great!  This is a much better solution.

Alan Stern
