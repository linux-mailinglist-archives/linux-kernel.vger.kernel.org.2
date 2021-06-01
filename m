Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7AF396F4F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 10:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbhFAIsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 04:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233354AbhFAIsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 04:48:38 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88288C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 01:46:56 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id e7so4418199plj.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 01:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=My2vf1o9P1BvHaxwXlTiuBUtfkfpIL2XgVqXjExCZx8=;
        b=ezhrcnnBRxAIAzaRnZ89x5V29XwK4SMf3gzA3NJHO2lYsPYJXFekIuWRmqza+eLmwo
         RRoivh+W17gO/QIPjzUA6YZLuXdhMQax0VqqXZY4msbghCFv7UVUHVF+AyeGjbFuG26s
         MdzWMjM+hdRlxQ8yMp/wMDRKWdLhyGkP/Or54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=My2vf1o9P1BvHaxwXlTiuBUtfkfpIL2XgVqXjExCZx8=;
        b=FqTXlSbSSAPz82Ze6LtML9wzyygQ0MPTHkDzKZue1u37P+XhIsu85qjhK+uNM1VU35
         9j6yRmWSyR57pUvGtdXIlB8Ug30A/S0Tiy3xqfL1VVAw1VDClFpbdOs1AKcvzCy8GMBY
         rmTKPbt3At9d/Kg5tSeOf0u4ScTed1q7mrPGSqXUjcUyjnZuj4EgpGHJVNBFjE/uFUqJ
         pnlsp11MlqZHFfBTaCndepeZUYz0mzo5KhJbePdu1nNlweYl0PI08mxgHAfhBwUFGAXH
         SKRBxgQ11dVVyAr8YNoDBoDymDqr+m/ZkNOA786lVA1ixNntgBaj3eGmfWuLhqyP2kbZ
         K4Nw==
X-Gm-Message-State: AOAM533Z2K3eD0djLdLTV7ikjJN+0mY0WYggd49ToJz6w7Zb/DEXuJvI
        tBPIQ4y3F8LKBY/ZXtxqXZpdsQ==
X-Google-Smtp-Source: ABdhPJz7sE8nUuEgxbxj7dHNZCQqV/rxJu5aJk54+EZiin2KVOukvmCGhxgGZKJBqgbbzZLoMF2CTA==
X-Received: by 2002:a17:90b:350a:: with SMTP id ls10mr24184505pjb.181.1622537216051;
        Tue, 01 Jun 2021 01:46:56 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:8cea:584c:cbae:6e37])
        by smtp.gmail.com with ESMTPSA id 15sm13085834pfy.15.2021.06.01.01.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 01:46:55 -0700 (PDT)
Date:   Tue, 1 Jun 2021 17:46:50 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv5 0/5] media: uvcvideo: implement UVC 1.5 ROI
Message-ID: <YLXz+r8PkKx1VMVc@google.com>
References: <20210501082001.100533-1-senozhatsky@chromium.org>
 <8583ed26-ef35-3341-5058-32dbf219d10c@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8583ed26-ef35-3341-5058-32dbf219d10c@xs4all.nl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/05/26 12:38), Hans Verkuil wrote:
> Hi Sergey,
> 
> On 01/05/2021 10:19, Sergey Senozhatsky wrote:
> > Hello,
> > 
> > 	This patch set implements UVC 1.5 ROI using v4l2_selection API.
> > 
> > v5:
> > -- fixed UAPI typo: STABILIXATION
> > -- moved V4L2_CID_REGION_OF_INTEREST_AUTO to V4L2_CID_CAMERA_CLASS_BASE+36
> > -- added more comments (Ricardo)
> > -- added V4L2_CID_REGION_OF_INTEREST_AUTO to v4l2_ctrl_get_name() (Ricardo)
> > 
> > Sergey Senozhatsky (5):
> >   media: v4l UAPI: add ROI selection targets
> 
> As mentioned in my reply to v4 0/5, I am quite strongly opposed to using the
> Selection API for this as opposed to using controls. Unless someone can provide
> strong arguments for using the Selection API, I am inclined to reject this.
> 
> Sorry about that, I probably should have been reviewing this series sooner.

Hans, any suggestions regarding the UVCs GET_CUR, GET_DEF, GET_MIN/MAX
requests handling?
