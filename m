Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E151F3CCE6E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 09:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234840AbhGSHZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 03:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234559AbhGSHZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 03:25:07 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697A9C061762
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 00:22:08 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id p36so15627900pfw.11
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 00:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m013tVjjd3FsutSGPHw/Qu0fBmOj83kUfzuI09JP+FE=;
        b=ei63j6Cl4O3K7AjxUG8IoPNs5p6VRFYRuL6xijrihthX3xb09ujKW6ABMk+Yp7w/E9
         HH47PpOnO9Cfrt+VU8UaqdXh3zU0zVp6h+8zgLftXdbRwy3WAk1eYxS8hiGI+M6Yr5dI
         PmfEIa9k2b8L/2VP1ZQPL4VzdbygQSgtx1tKfUll3eJZqYwWB6iTsar53u5QmWuMITK5
         CRQKuIvZ+H8UcVoQk9P18/tPlipXuxE2oi4zo5Z27lz1qzwg7FlokDOVLufr7O9mr5cD
         Tnywfacq59Nt5Z4Ec+7tiuJqL09VWLFWflhnTUgX1n3rqmf1iCnXS9ohXXGzB+iQ48Me
         U+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m013tVjjd3FsutSGPHw/Qu0fBmOj83kUfzuI09JP+FE=;
        b=LAb8mpq/bFPwB7FktHqd1nkhUlFeYmOQeoASHsF4+fj9ctx0qIEGT8zcblBDFyzLOj
         W9mF0OGPxWdZl2gKb5MGmOsNyEOrbupa0ctoFO70RBdGvfzerfXqCD7qyUz7ZmTFFxPt
         NXWutxqve/uwU2tdlJAvH650r3kJODJSErC1A84VdaRJkJLbOmG4+RmU34d9ExZpXNm1
         m+bPA1GtPUOUSyhi1t8Mgb23bAPWWyRDWB9OrOk+9QnqMoIRbSSv7DUrQkFrPj9nfWmZ
         AIv2wN6/8VLY/seKSBTMsl2eTgYgbNEVfrU5M1SIF1LKrGUytUZcJfvBPiagq1fvzmeo
         Q+bg==
X-Gm-Message-State: AOAM532mkuxFyeLqJDrJJMJt5yACykJw/RkbVF7nerpZKtdbYj/TAETu
        HB6fOEPZ8b4Z4TOxUKfPMkM=
X-Google-Smtp-Source: ABdhPJyCSzVs/JgE9YiOABMeV+47aiIlcnpmGWTcjX6ogapVi1cYpeL/hPjjCIOSKiqrEt4Q8htVwA==
X-Received: by 2002:a63:794:: with SMTP id 142mr23897510pgh.344.1626679327808;
        Mon, 19 Jul 2021 00:22:07 -0700 (PDT)
Received: from localhost (g142.61-125-55.ppp.wakwak.ne.jp. [61.125.55.142])
        by smtp.gmail.com with ESMTPSA id x30sm18533897pfh.126.2021.07.19.00.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 00:22:07 -0700 (PDT)
Date:   Mon, 19 Jul 2021 16:22:05 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org
Subject: Re: [PATCH] openrisc: rename or32 code & comments to or1k
Message-ID: <YPUoHZ57b00bT0Hz@antec>
References: <20210716022338.19342-1-rdunlap@infradead.org>
 <YPUCB7dSCHWrYHBl@antec>
 <96469a3e-82b5-f2b1-c0ea-5975e85332ce@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96469a3e-82b5-f2b1-c0ea-5975e85332ce@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 18, 2021 at 10:00:42PM -0700, Randy Dunlap wrote:
> On 7/18/21 9:39 PM, Stafford Horne wrote:
> > On Thu, Jul 15, 2021 at 07:23:38PM -0700, Randy Dunlap wrote:
> >> From Documentation/openrisc/todo.rst, rename "or32" in the
> >> source code to "or1k" since this is the name that has been
> >> settled on.
> > 
> > Hello, the kernel test robot found a build failure with this.
> > 
> > Will you send the update for that?
> > 
> 
> Hi,
> 
> The robot problems are not related to this patch (they were
> there before this patch), but I will send an update if you insist.

No problem,  I didn't investigate but just thought you had missed renaming
something.  In that case I will queue this and also look into fixing the robot
warning.

Thank you

-Stafford
