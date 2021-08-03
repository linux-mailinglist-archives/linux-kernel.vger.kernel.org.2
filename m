Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 327DE3DE7D0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 10:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234379AbhHCICu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 04:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234238AbhHCICm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 04:02:42 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A775C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 01:02:27 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id u9-20020a17090a1f09b029017554809f35so2714903pja.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 01:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=B3GY5pHxl40fgyTRDEfHUIewqx+99afdPdvQA2cgGa0=;
        b=REQHBowNw7Yaj6sttRmL2EmUojpe/e5L7E7uBMO3aeF3aqglCcSmiViK2x0a167qvn
         PvXfS/iYbFsIEC4FMMC73h3IlIYQcDvhFpp6WqULgxnPmwV5XJcFC10MKTEFfOoplddp
         c93ifMaPO6OwQJn6Eb76zuBl7+9yfDmb0OTES4hB7IG5HJWEb+C69jcSzanX+kLj5CHu
         YsCSv9ns98ysu9FiybswkvWoOOtdil5/c0bQMFe+KigUiP6ou+1YppgwiDblKP7ctUR8
         B7BvV/k+YBsGsYfXtEhOt1xy/cgc6A7D9HKJP86CEE23xoUCok/jRdCCAm4a0QDKQ5dg
         XbrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=B3GY5pHxl40fgyTRDEfHUIewqx+99afdPdvQA2cgGa0=;
        b=GSO24ik8M5CsWDM4MRMNOTbFvEPtOwLJCXHVFBcjT/wkYaagOx0jWEHWFSadrQxchC
         ubnkDOplcqYMIdsqQfdq6O9TzVQztcXEBlHZFTkaOilsg6EOjX263PDp0G9fWtGQI2Wo
         pGE4D4IYA1OC6VFJtBSuBXKGz9hbmdYpZCH32EEE/XMr8fAntdfddgofzkStw9YdPdzc
         wxYMbCZHiSrcKf3EpfWfZJ5e8ZMGKtCSdxRn6n9DDfLm/HVF/5DCOZ9OWXwuC6eXy9Sk
         l8gNW1oW4L+jYURWFbNUikYrqjkm9w+Vx+L0OrHA3j2EFgdQEiLbp15O2dHFuBcutA3B
         kV0w==
X-Gm-Message-State: AOAM533ZOqdXnOSEG/H/UxbejYSd2RuLTchh4X/H37u2LTa6/k0vwlJC
        5C9tXAWwDLrWb9RCVrTOQ2fahitWmMyM7FIcZpE=
X-Google-Smtp-Source: ABdhPJyyBN4Qax5+FbTreuWweYO6qukRB21dNj4OreuJ9oHEj+ndETuOk6bnNxtgKJgCFOBS86jtEJiHnYJeS6v0TLk=
X-Received: by 2002:a17:902:a406:b029:12b:c50a:4289 with SMTP id
 p6-20020a170902a406b029012bc50a4289mr17549624plq.56.1627977746836; Tue, 03
 Aug 2021 01:02:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a20:4293:b029:1f:3531:9c52 with HTTP; Tue, 3 Aug 2021
 01:02:26 -0700 (PDT)
Reply-To: sgtkaylam28@gmail.com
From:   ken manthey <manken827@gmail.com>
Date:   Tue, 3 Aug 2021 01:02:26 -0700
Message-ID: <CAHbNM4EDbkbZbUGsaioBq4JAT=Ua965C7KaQoGP=6+hU4QUdcg@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,
Please did you receive my previous message? Write me back
