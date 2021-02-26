Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C80CB325B08
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 01:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbhBZAld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 19:41:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbhBZAlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 19:41:23 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02739C061756
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 16:40:43 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id o38so5087924pgm.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 16:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wEaML8KCNtCq/PXIO9BiOe8CWVBSVfAXNbUXFDtW/30=;
        b=oaXIKI/fXvSGZ+kamObpOTTUrtLmxmAlOXARJyixgzRU1cnmxUAY4NQ2GJbrCC64Tk
         hPemgawRJ3fqXV/YOGPlRBXP7lJa29kUZPpCjvKS8oNyaZd/Ocd89etX5l3MZbztT0vN
         KN6RSlkLB2SKZQjKUpU7f1kqvZTOZsrR6DNJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wEaML8KCNtCq/PXIO9BiOe8CWVBSVfAXNbUXFDtW/30=;
        b=iBj5mT3mW1oWVw930E7yNqhs8VoO0cn4eq7mWeDv114hBdopzUSnXJD0V58rXvzxaB
         2JcLNOTY7I4r+L1iTJa3JI6FSrYswMCKY4U14CKbzdfdUU508KqhIXjAY/9OJAT6GymB
         cWEOYfQHXCkd3PT8NQaOLRnDIjT9IKygJiouWUuGXtS/0PvkHGt7MtMSFRrbMhAIDCxg
         RpWENdMgobwCa6DOdsLwvV3/uvZEGrZWuEcRVDpQ0RrJs/PFI4j0HK6viKysSZvzeDtl
         g7Rvci3Z7u+7xcwLoCVOsJhKPB9Felk7/j7ddIb2WubyvSZEjg8u4dvX+kliYrZOJbGx
         RQnA==
X-Gm-Message-State: AOAM530bim3VL42vYYj4sw2HnFzRVu56ru4+D2/PPrjzLZqd3swaMmf+
        oj1apt1FKiTcH9a/EPvGWei15Q==
X-Google-Smtp-Source: ABdhPJwHFQmhApbH06Zhg6qz15u/YV+AQlBAktrkCfYVcsgMrwi9OU8ab/1zlRBl2i961yAiGoFUWQ==
X-Received: by 2002:a63:1561:: with SMTP id 33mr524733pgv.13.1614300041539;
        Thu, 25 Feb 2021 16:40:41 -0800 (PST)
Received: from localhost ([2620:15c:202:1:1d8:8d0c:f75e:edd8])
        by smtp.gmail.com with UTF8SMTPSA id p26sm7680597pfn.127.2021.02.25.16.40.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Feb 2021 16:40:40 -0800 (PST)
Date:   Thu, 25 Feb 2021 16:40:39 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Rob Clark <robdclark@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/13] arm64: dts: qcom: Add sc7180-lazor-limozeen skus
Message-ID: <YDhDhwXZ5P1/sxzR@google.com>
References: <20210225221310.1939599-1-dianders@chromium.org>
 <20210225141022.11.I556326b24441e22c8c429ce383cc157c7aaef44b@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210225141022.11.I556326b24441e22c8c429ce383cc157c7aaef44b@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 02:13:08PM -0800, Douglas Anderson wrote:
> This is a SKU variant of lazor.  Add it.  This squashes the downstream
> patches to support this hardware.
> 
> NOTES:
> - The non-touch SKU actually has "innolux,n116bca" but that driver is
>   still pending in simple-panel.  The bindings have been Acked though.
>   Things work well enough with the "innolux,n116bge" timings for now,
>   though.
> - The wonky special dts just for "-rev4" arguably doesn't need to go
>   upstream since they weren't widely distributed, but since a few
>   people have them we might as well.  If it ever causes problems we
>   can delete it.
> 
> Cc: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
