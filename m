Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 103FA3F9C04
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 17:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245413AbhH0Pxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 11:53:30 -0400
Received: from smtprelay0105.hostedemail.com ([216.40.44.105]:44624 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S241778AbhH0Px2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 11:53:28 -0400
Received: from omf06.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id E1A66100F1E35;
        Fri, 27 Aug 2021 15:52:38 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf06.hostedemail.com (Postfix) with ESMTPA id E864E2448BC;
        Fri, 27 Aug 2021 15:52:37 +0000 (UTC)
Message-ID: <52ab858d1061bd8c0da8bba247235d92a5e4a0ec.camel@perches.com>
Subject: Re: [PATCH 5/5] staging: r8188eu: Use vsprintf extension %phCX to
 format a copy_to_user string
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev
Date:   Fri, 27 Aug 2021 08:52:36 -0700
In-Reply-To: <YSkEWBbOJmNSI4zn@kroah.com>
References: <cover.1630003183.git.joe@perches.com>
         <152e1b8f84c4686ea38182ca55344ed7f2cede65.1630003183.git.joe@perches.com>
         <YSildgE0Ul4akIUJ@kroah.com>
         <903a73b791466918ca72c8fc62406acb86e93018.camel@perches.com>
         <YSkEWBbOJmNSI4zn@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.48
X-Stat-Signature: y579dc7es1hqde1gffbini44sjqsscse
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: E864E2448BC
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/tBn5XILEQLaSLCcJfkgGrrb6KNxPZqiI=
X-HE-Tag: 1630079557-674807
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-08-27 at 17:27 +0200, Greg Kroah-Hartman wrote:
> On Fri, Aug 27, 2021 at 08:23:31AM -0700, Joe Perches wrote:
> > On Fri, 2021-08-27 at 10:42 +0200, Greg Kroah-Hartman wrote:
> > > On Thu, Aug 26, 2021 at 11:43:05AM -0700, Joe Perches wrote:
> > > > This reduces object size without changing the string content.
[]
> > > > diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
[]
> > The copy_to_user bit (2nd diff block) is nominally an ABI and is upper case.
> > IMO at a minimum, it's bad form to change it.
> > 
> > @@ -3075,8 +3073,7 @@ static int rtw_p2p_get_go_device_address(struct net_device *dev,
> >         if (!blnMatch)
> >                 sprintf(go_devadd_str, "\n\ndev_add = NULL");
> >         else
> > -               sprintf(go_devadd_str, "\ndev_add =%.2X:%.2X:%.2X:%.2X:%.2X:%.2X",
> > -                       attr_content[0], attr_content[1], attr_content[2], attr_content[3], attr_content[4], attr_content[5]);
> > +               sprintf(go_devadd_str, "\ndev_add =%6phCX", attr_content);
> > 
> >         if (copy_to_user(wrqu->data.pointer, go_devadd_str, 10 + 17))
> >                 return -EFAULT;
> 
> That looks like a horrible driver-specific api

Horrible could be used to describe most realtek code in the kernel.

> that no one will really
> be using and will be removed from the tree soon.  So it can be changed,
> no need to worry about any "compatibility" issues here.

Fine with me too.  I just did it for completeness.



