Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B701420504
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 04:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbhJDC6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 22:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbhJDC6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 22:58:05 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB16C0613EC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Oct 2021 19:56:16 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id m3so64968091lfu.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 19:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:from
         :content-transfer-encoding;
        bh=wjunn4+x2QEs4HRrQcozT7INn2DM0lGSHIZkmkDz3T0=;
        b=A03CcmJwE8ugr780JQsuYfJ1y40cpLT76UbtjkRLwW1lo72fYVmQjSpKrC7iwfRQXF
         9aA0rc69+QlEZXaiQlxA3S+CA47mhVAV7ZlkRgudSzz3WpywJt3W/7UH7EVToXd6ePGz
         6g3Treq2zdJjj9hvErSYq0E5GUlXm190u1x0EfK3PKnIHsGlMdXxwbH00lz0BW9lH6XY
         sXEZFRYx3QcPla4A3x6XUdVJoXsPcLhxXq6YHtdYGxY+Rt6BhtYSd57gaI4agtfk9asv
         LrzzbcsUg/C9BVSZvTqZxm0b4VZj/RxYiEMJaXbyf/K9vdGd6y1TvlKMTUYFAmyAdbhZ
         y1VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:content-transfer-encoding;
        bh=wjunn4+x2QEs4HRrQcozT7INn2DM0lGSHIZkmkDz3T0=;
        b=HWldA2vtGDX6lSrd8nSYZL4lZx6oyc1ZgWjTepkqZnKet2PhXQmyQijzwkt/VePnWr
         VEGCCpI2meolFf5+x9TFaXkj2fPmivR6R0e+FFMTms04/LhVUGrnJcYmYe6ci3+cg0J7
         0i44K46uvbmXjjMfOtCwQEfg3ZoSorwU8fmPjPe+tPhSMM8T2jfanUEWCmDkmjdrH8JV
         QEuvAuIZ+4NHjgx/GmQYuE5ZhJCz2rnxRyZLPyTI/HwJEGyEleXoNtC/ZF3h47Mg+H+z
         Hr2qrm2X2hf8n/qjO2SzRZ+TTq/Xnr1HjaCzuFX7EjASDMiDgGnHfRFGLx95wTbtAXau
         b4EA==
X-Gm-Message-State: AOAM530eoc08O3OpHb+WJ1VQhn3Em08hVFpvrf9NnXZ1R+vqGFBEzVss
        eiEBCyndBtWTswNoSIkit+XuLrqE1XjccQ==
X-Google-Smtp-Source: ABdhPJwHSgPzCYruhtY70Sah2MWd8igCLnFynJL9/jkEU5spD/C4Ov3CbaPja8y7aGKEunkMKn6c7Q==
X-Received: by 2002:a2e:5705:: with SMTP id l5mr13714736ljb.456.1633316174696;
        Sun, 03 Oct 2021 19:56:14 -0700 (PDT)
Received: from [10.9.0.9] ([185.213.154.162])
        by smtp.gmail.com with ESMTPSA id t3sm1413211ljg.68.2021.10.03.19.56.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Oct 2021 19:56:14 -0700 (PDT)
Message-ID: <2991ba73-b8cc-3a2d-f2c6-55b64fdabb1d@gmail.com>
Date:   Sun, 3 Oct 2021 21:56:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
From:   Drew Fargo <drew.fargo@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

unsubscribe

