Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59AC63F9BA8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 17:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245477AbhH0PYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 11:24:25 -0400
Received: from smtprelay0138.hostedemail.com ([216.40.44.138]:55128 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S245358AbhH0PYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 11:24:24 -0400
Received: from omf10.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id D3740182CED5B;
        Fri, 27 Aug 2021 15:23:34 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf10.hostedemail.com (Postfix) with ESMTPA id E97B22351F5;
        Fri, 27 Aug 2021 15:23:33 +0000 (UTC)
Message-ID: <903a73b791466918ca72c8fc62406acb86e93018.camel@perches.com>
Subject: Re: [PATCH 5/5] staging: r8188eu: Use vsprintf extension %phCX to
 format a copy_to_user string
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev
Date:   Fri, 27 Aug 2021 08:23:31 -0700
In-Reply-To: <YSildgE0Ul4akIUJ@kroah.com>
References: <cover.1630003183.git.joe@perches.com>
         <152e1b8f84c4686ea38182ca55344ed7f2cede65.1630003183.git.joe@perches.com>
         <YSildgE0Ul4akIUJ@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.82
X-Stat-Signature: dyhdiwdkbtxna4fxq44myoxi3y4oc5y7
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: E97B22351F5
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18KFntoaiBi32GNTcRPB7ZKasui37n4qqA=
X-HE-Tag: 1630077813-606056
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-08-27 at 10:42 +0200, Greg Kroah-Hartman wrote:
> On Thu, Aug 26, 2021 at 11:43:05AM -0700, Joe Perches wrote:
> > This reduces object size without changing the string content.
> > 
> > compiled x86-64 defconfig w/ r8188eu and gcc 10.3.0
> > 
> > $ size drivers/staging/r8188eu/os_dep/ioctl_linux.o*
> >    text	   data	    bss	    dec	    hex	filename
> >   72556	   1548	      0	  74104	  12178	drivers/staging/r8188eu/os_dep/ioctl_linux.o.new
> >   72758	   1548	      0	  74306	  12242	drivers/staging/r8188eu/os_dep/ioctl_linux.o.old
> > 
> > Signed-off-by: Joe Perches <joe@perches.com>
> > ---
> >  drivers/staging/r8188eu/os_dep/ioctl_linux.c | 9 +++------
> >  1 file changed, 3 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> > index ab4a9200f0791..048164659d872 100644
> > --- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> > +++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> > @@ -2907,10 +2907,8 @@ static int rtw_p2p_get_groupid(struct net_device *dev,
> >  	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
> >  	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
> >  
> > 
> > -	sprintf(extra, "\n%.2X:%.2X:%.2X:%.2X:%.2X:%.2X %s",
> > -		pwdinfo->groupid_info.go_device_addr[0], pwdinfo->groupid_info.go_device_addr[1],
> > -		pwdinfo->groupid_info.go_device_addr[2], pwdinfo->groupid_info.go_device_addr[3],
> > -		pwdinfo->groupid_info.go_device_addr[4], pwdinfo->groupid_info.go_device_addr[5],
> > +	sprintf(extra, "\n%pM %s",
> > +		pwdinfo->groupid_info.go_device_addr,
> >  		pwdinfo->groupid_info.ssid);
> 
> We can just use the lower-case one here, no need for a new modifier just
> for something like this (i.e. log file output)

That was just a trivial conversion of log file output and is lower case
as log file output is not ABI.

The copy_to_user bit (2nd diff block) is nominally an ABI and is upper case.
IMO at a minimum, it's bad form to change it.

@@ -3075,8 +3073,7 @@ static int rtw_p2p_get_go_device_address(struct net_device *dev,
        if (!blnMatch)
                sprintf(go_devadd_str, "\n\ndev_add = NULL");
        else
-               sprintf(go_devadd_str, "\ndev_add =%.2X:%.2X:%.2X:%.2X:%.2X:%.2X",
-                       attr_content[0], attr_content[1], attr_content[2], attr_content[3], attr_content[4], attr_content[5]);
+               sprintf(go_devadd_str, "\ndev_add =%6phCX", attr_content);
 
        if (copy_to_user(wrqu->data.pointer, go_devadd_str, 10 + 17))
                return -EFAULT;



