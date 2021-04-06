Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA468355A2F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 19:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244542AbhDFRVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 13:21:51 -0400
Received: from smtprelay0183.hostedemail.com ([216.40.44.183]:53336 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233676AbhDFRVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 13:21:50 -0400
Received: from omf15.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id C3182180428ED;
        Tue,  6 Apr 2021 17:21:41 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf15.hostedemail.com (Postfix) with ESMTPA id 601A2C4182;
        Tue,  6 Apr 2021 17:21:40 +0000 (UTC)
Message-ID: <7d7be8bcc0e80d826083890ed7791070ad25e603.camel@perches.com>
Subject: Re: [PATCH] staging: greybus: Match parentheses alignment
From:   Joe Perches <joe@perches.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
Cc:     johan@kernel.org, elder@kernel.org, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Date:   Tue, 06 Apr 2021 10:21:38 -0700
In-Reply-To: <YGxhrLZPIPjILWUH@kroah.com>
References: <20210406124259.GA96537@zhans> <YGxhrLZPIPjILWUH@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 601A2C4182
X-Spam-Status: No, score=0.10
X-Stat-Signature: c6sadr7ectuaniqta9h19aj9ajc7unsy
X-Rspamd-Server: rspamout04
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+jIsA223eKF3R6VcYnwZUQdsfBWilGY3I=
X-HE-Tag: 1617729700-769365
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-04-06 at 15:27 +0200, Greg KH wrote:
> On Tue, Apr 06, 2021 at 06:42:59PM +0600, Zhansaya Bagdauletkyzy wrote:
> > Match next line with open parentheses by adding tabs/spaces
> > to conform with Linux kernel coding style.
> > Reported by checkpatch.
[]
> > diff --git a/drivers/staging/greybus/camera.c b/drivers/staging/greybus/camera.c
[]
> > @@ -378,8 +378,8 @@ struct ap_csi_config_request {
> >  #define GB_CAMERA_CSI_CLK_FREQ_MARGIN		150000000U
> >  
> > 
> >  static int gb_camera_setup_data_connection(struct gb_camera *gcam,
> > -		struct gb_camera_configure_streams_response *resp,
> > -		struct gb_camera_csi_params *csi_params)
> > +					   struct gb_camera_configure_streams_response *resp,
> > +					   struct gb_camera_csi_params *csi_params)
> 
> And now you violate another coding style requirement, which means
> someone will send another patch to fix that up and around and around it
> goes...

None of the coding style document is an actual requirement Greg.
It's all rules of thumb.  Useful rules, but not hard and fast right?

To me, the biggest issue with this code isn't whether or not the
code is aligned at open parentheses or stays within 80 columns,
but is the use of 30+ character length identifiers.

Using identifiers of that length makes using 80 column, or even
100 column length lines infeasible.

Perhaps seeing if include/linux/greybus/greybus_protocols.h
could be updated to use shorter length identifiers might be useful.

The median length identifier there is ~25 chars long and the
maximum length identifier is ~50 chars.



