Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF37345AA0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 10:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhCWJS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 05:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbhCWJS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 05:18:28 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D119CC061574;
        Tue, 23 Mar 2021 02:18:27 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id f12so14420027qtq.4;
        Tue, 23 Mar 2021 02:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=taC5iTg2L9AbDqKdhyqnjomrfYs1luG7hyDu4VJsun8=;
        b=i8vWEMtREBWsw1tSFO1eopxRawwS8ybjqM7yG/yDLR6yxkVjDzPo6gQbIMo80Sk0sL
         jdgFkvgZED91FHqk+JlUJe3Pi2ciXp5XFDNlJSv2la9qbMeUN7hh0V1Dsivob8bG1EoZ
         4yQIFO5F+/sF99SkVfM3HRR3EwiNtTabXjtqZVPOjCPI2xDTPxsgMFv7I3ws3pyXLCiY
         WKEo+4N7ZqzAhM3ksHyteHtnRdIiP4WbsC9dI3l37fEj2u0GDr1+l6eiTMWIOZb4+D5t
         OLBf0mlap65H3qlq0tXDK/EZ+OtYr6wfUInHH1436QC3xVSSAuygWLaz+2wTtvtjl0wd
         CPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=taC5iTg2L9AbDqKdhyqnjomrfYs1luG7hyDu4VJsun8=;
        b=s8AUR9LsPpMVsMo+0dD+tr1zsJEBnfe+uLoeUrp7GRAqTUqlvop2/gV4/NtYf0pIDb
         sHzKFIy4JjujkPN7/M40iKQdHfqqCIlDm3tpZiDfpdUsrlz4o96M7QZX3Ofj1xL/2Gx4
         WJOS5WO8T/4FelB2vEGn1vOtif3I54PO5gO5I2G31XRCeVTmknwriPGTDAb0qMJjhD1t
         LpDY8O0tgFuPbyx32P8fvsLm9yZoAXHsFDCRivED2JlJLc8g/XWYHcvmxl1uso6jyfaq
         am+T7SdVyInANb/fBmGEuGnsxSmg2s7r8qf2MgynOLeJ8ipTdjztDfnZGxRGdr/aNKPt
         4bPw==
X-Gm-Message-State: AOAM532dYivLwbQ5ZBoZrSF50+71oBE0R508GWxHegQmUXh9aZMlXvcu
        TBHMgx3b3CwvCY4VTSLN30o=
X-Google-Smtp-Source: ABdhPJwxCLmFIWf6Q/MBn07+wMtogtNdPHOzDlZtODUQzSIFvZhp48dL8dX7vKfUJDaZ06VmG7r49Q==
X-Received: by 2002:ac8:6e9c:: with SMTP id c28mr3538649qtv.117.1616491107124;
        Tue, 23 Mar 2021 02:18:27 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id h75sm12921360qke.80.2021.03.23.02.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 02:18:26 -0700 (PDT)
From:   sj38.park@gmail.com
To:     SeongJae Park <sjpark@amazon.com>
Cc:     SeongJae Park <sj38.park@gmail.com>, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sjpark@amazon.de>
Subject: Re: [PATCH] docs/kokr: make sections on bug reporting match practice
Date:   Tue, 23 Mar 2021 09:18:19 +0000
Message-Id: <20210323091819.3617-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210316092043.18477-1-sjpark@amazon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jon, could I ask you a review for this patch?


Thanks,
SeongJae Park
