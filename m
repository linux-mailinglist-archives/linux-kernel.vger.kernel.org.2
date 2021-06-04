Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72ACA39BB36
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 16:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbhFDOzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 10:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbhFDOzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 10:55:46 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B3DC061766
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 07:53:50 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id i68so6007392qke.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 07:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mv5xRZvwxzLpkyFYX04NoAaniMme18OSg+lyvmirIn8=;
        b=nI3sMZAHYKKamUkEAD6j+UguzKc3c5ye1tKyXZu7S4SaFqCCgX/8FOUoc0CclcVsV9
         m2pYA6OyKlEhHENvDWkjYmI9JmhaWPmCObUV3PblujHXaO/aJQpYMSTlP/wu/YyG1S1t
         BHFPlWIUHDmCOwAQ58+Q4wSQhRK+2QhQ/YVCjIZqJWySgW39yqzaRUB/gMWyp/tz7aA/
         zaPzVEY9UY5YPV4PPkmqk3xWyY0tNkXoiwOmk5530oT1wqQdJeDe7T/4VUcIxkh8Qx5W
         OyWIwxsUglOfqujGfFc0nOIoo97Oru1TYcV0nRC2RvrMSpXINUPry3dIWLOE4Z8xnS8Q
         USKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=mv5xRZvwxzLpkyFYX04NoAaniMme18OSg+lyvmirIn8=;
        b=UT6IM3tudgF94K9IpA6SzA8yqCzRawhimvOWUMFT2FeI139/RDU9CiTmrSJrKcN7Tj
         hc37qJbk+auX+DzNzhOil45xVSYFE5J/bdp5bTytiA4J97I6NkBaqUi6OlPZb4hSjgoj
         l88GKiClkP4BfXIbLoJp908GbRe0XEOogJ81soyEND6u0sJzf8O9P8OKYv36Fur/SkAd
         q/ZrQRSalpiUP31D6YFWo3kMHI2hRFaHYYps4VeRRIzy8lu3sj6qW8EpeoWd+2FqH77F
         8VysRjZc21k+xtBahDMpLJEmUkYLNc3OEgV8yhqqEHUTTa1w+fuekb2XB8WfFRuuExCa
         ioHg==
X-Gm-Message-State: AOAM533ENaEZm+nDRg/uua+KXsyBT7fH8HpcWg+T/0yzEWTUYr3nb8lJ
        z/pg/5v542g3q+DQTYuEuo4=
X-Google-Smtp-Source: ABdhPJwrRr6TfIRmXx6W6D7AJftoWLZMzl78+VxW+VFUIWY8JyW3pitcwJeZL3+91xXn3+anM2wKrA==
X-Received: by 2002:a05:620a:15b4:: with SMTP id f20mr1671473qkk.334.1622818426727;
        Fri, 04 Jun 2021 07:53:46 -0700 (PDT)
Received: from localhost ([199.192.137.73])
        by smtp.gmail.com with ESMTPSA id j127sm4193552qke.90.2021.06.04.07.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 07:53:46 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 4 Jun 2021 10:53:45 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Julian Wiedmann <jwi@linux.ibm.com>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH wq/for-next 1/2] workqueue: replace open-coded
 work_pending()
Message-ID: <YLo+eaMt/le6QlKA@slm.duckdns.org>
References: <20210602111655.3808580-1-jwi@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602111655.3808580-1-jwi@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 01:16:54PM +0200, Julian Wiedmann wrote:
> Use the right helper to check whether a work item is currently pending.
> 
> Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>

Applied to wq/for-5.14.

Thanks.

-- 
tejun
