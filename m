Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A9935DAA2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 11:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242764AbhDMJFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 05:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245312AbhDMJE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 05:04:26 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1D6C061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 02:04:05 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id j5so14659918wrn.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 02:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=qAycWgL50Bb206IaW++W2ixsVOoTd8eyjvhFQR4cHts=;
        b=rJmE+oeCKQqym+3INuHfS/BbPhfPCQO+TBuJJzrhd6TgDvAX+BpDSa8sVHElkL0/SD
         bdsKrG+bMPsHoTBhJB0OvTCp2wvQOMRfJsUKp4Hagx91VzQ1ad+LGa9Bb9Mj0vBiKemG
         cu9aLsOzBNdYcJSth/g7Y14djCTebwThuZD6TWSg3aSrgx+tUutbYuc8t01jKHj50ats
         YpnU6+KUieFh07bezbrVUVtBF317BJmQyc2Yei5uXNHN9XKhaGpgd2WCGLgxPujb31tx
         JC+5zPHvbUG/f0K5YTBUry5G+Y4NsPjx8jWURDI6iwFDQUbYJ9Y9E/0xleXPc4gaaMAN
         9EAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=qAycWgL50Bb206IaW++W2ixsVOoTd8eyjvhFQR4cHts=;
        b=Eyb1HRNHUm/5rPAKL6BeiUrfHYKD/malZLJwbkG15xyZpC4Ps9AdyZgrN8TEt3HHIi
         hg9H2tTLcbZ5ph5cK02ygf3XrmJ/+kgItIrUbXmW+85fsPj8N7HPPsStsb4yPoOCwM3c
         Q6jmTMwVnCp9lw5uFgtNnck3p/ymTlXDDo3NUKmFDLUIQfpjV8cAo93ALWHZNEOsIzCL
         2ZfsLtUuKb1RL3ZylatLt/IjgcPgQ+dRiwYGRrtOHTIjMlRx3+bCpmn4a26rCEzM+TUd
         MMgIU0slXlo+y9eS9p4jMvYashKGoQICeL9LTkDWzq8fP2/e56Fgg2teuawt9hJbKqYH
         6xzQ==
X-Gm-Message-State: AOAM532W1D/WmaARw7vpCkks4PwSePz9czPPjHhSisXSpocwLHGJGhBN
        1hr/SebcmElyp1ZT2RTSZyk=
X-Google-Smtp-Source: ABdhPJxDqNctt3Zm6LpWHn9ldjzDoS5gfH8D62Bn62qiJ1xCmEbvhdcWM2q2docMiG7y7MCkPzxdFw==
X-Received: by 2002:adf:f543:: with SMTP id j3mr34999738wrp.259.1618304644560;
        Tue, 13 Apr 2021 02:04:04 -0700 (PDT)
Received: from agape.jhs ([5.171.81.136])
        by smtp.gmail.com with ESMTPSA id g84sm1801370wmf.30.2021.04.13.02.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 02:04:04 -0700 (PDT)
Date:   Tue, 13 Apr 2021 11:04:01 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org, joe@perches.com, julia.lawall@inria.fr
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: cocci script hints request
Message-ID: <20210413090400.GA5477@agape.jhs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I would like to improve the following coccinelle script:

@@
expression a, fmt;
expression list var_args;
@@

-       DBG_871X_LEVEL(a, fmt, var_args);
+       printk(fmt, var_args);

I would  replace the DBG_871X_LEVEL macro with printk, but
I can't find a way to add KERN_* constant prefix to the fmt
argument in the + code line. If i try this

@@
expression a, fmt;
expression list var_args;
@@

-       DBG_871X_LEVEL(a, fmt, var_args);
+       printk(KERN_DEBUG fmt, var_args);

plus: parse error: 
  File "../test.cocci", line 94, column 20, charpos = 1171
  around = 'fmt',
  whole content = +	printk(KERN_DEBUG fmt, var_args);

how could I do this?

thank you in advance,

fabio
