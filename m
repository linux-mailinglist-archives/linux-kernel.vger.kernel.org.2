Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A74643FA55F
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 13:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbhH1LRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 07:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233831AbhH1LRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 07:17:15 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DC2C061756
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 04:16:25 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id w6so5731636plg.9
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 04:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Vu5jBjunzDOP0PLhWuxgdCxdhyX6vl/xQHEmao6wMA8=;
        b=G2XUXbT/Wq8fVmfj6bNjX8cIltYnuxQeiHmXcsilQNimtRh1BtrHy0m2/KzJMMSYF/
         bookN6aCCylFp60CExRwyvi2qwi9Cy5e9pysPGM/csKoda6KYL4EZjYp32rA6rYGHBeD
         G6LKB284QsNYSvhXcAbCbOO+vCB+1860ayvlQ7lu3OVpUdU9B2BD2XdqZ/hznaZfoIoX
         7pYVsiCcd6KfpNhgUCg53b+/Lrdenu7N1eBkr9fM1nlpuLADZh2as+yYcqBA1ZCXf6Pu
         IsHtlZ+9iqW0ttO4fu3Q7KuZCQ6pzAHNJcv7kC6mXMLbO311VWbQpatnpXG0Cqb8B/zH
         6iFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vu5jBjunzDOP0PLhWuxgdCxdhyX6vl/xQHEmao6wMA8=;
        b=a+JEnO713vBSi6jW4lt0lmiQsnODGIv/SEh+iPVsStW4Ab1oqJ7gZkDwRVv/zEhNmz
         U6yr+jfOTKUl56akh2VjzH/Q/KqVhwYd4+2rb0KZ3levCJoaQw8Wco7BUaUFc0W3Cv2Y
         3wE7AXYrja4P9z/jvnAJNqdFfOTNJeZoAYBm8Qd/sUr9CMzfHdd0/tcR6O4YGUN3xkXt
         EfW9dE48QzsU6zgZJ0NMRJhmzAWIk9/dtudfppDNjPBwYsQOprFoDt64QUI51Wfub4j1
         OcKyYLIkLm+ersbBzL7yVbRGCgIdUEjAberiFPpWyuB+TfE/a+mM4sDIddltejpAgXiq
         9FBQ==
X-Gm-Message-State: AOAM532Yo4I8wzNlO/VHaDViDj0fH58KqKuyW76tlS7MudqIRhlvZlA8
        Zm2OUf1vi0NbOgDtDqqCGu8=
X-Google-Smtp-Source: ABdhPJzpZk3hRz+5bRioH81N+ZTuPsyV4pYw01kHLo+T5Q8NNLmy8h1vr86VEk0jN7Lh2rz9SVNyvQ==
X-Received: by 2002:a17:902:dacc:b0:135:960b:1754 with SMTP id q12-20020a170902dacc00b00135960b1754mr13164755plx.77.1630149384542;
        Sat, 28 Aug 2021 04:16:24 -0700 (PDT)
Received: from localhost ([49.206.124.188])
        by smtp.gmail.com with ESMTPSA id t10sm14595617pji.30.2021.08.28.04.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Aug 2021 04:16:24 -0700 (PDT)
Date:   Sat, 28 Aug 2021 16:46:22 +0530
From:   Aakash Hemadri <aakashhemadri123@gmail.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Martin Kaiser <martin@kaiser.cx>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHi v4] staging: r8188eu: Remove
 _enter/_exit_critical_mutex()
Message-ID: <20210828111622.3jytsm56cblqkvil@xps.yggdrasil>
References: <20210828105109.5776-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210828105109.5776-1-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unrelated to the patch, but if this was a typo then you can easily modify
the subject prefix for new versions with `-v4` using `git format-patch`

-Aakash
