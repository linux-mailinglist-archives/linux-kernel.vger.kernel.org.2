Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB303D350E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 09:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234243AbhGWG3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 02:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234136AbhGWG3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 02:29:23 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF225C061575
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 00:09:57 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id u9-20020a17090a1f09b029017554809f35so7653202pja.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 00:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hhz/iZSw+eTxaAKD6erQO6gxj2fpcxGd6dd5TC5JHcU=;
        b=ChimLYGVj9C3Wksd8ymlEPI8lxLxNCOz4pbiYV5Nezbx4JY4GGQfj7BAXgdIndsCNd
         Y9fabsGNYLpUbyITao4PEnrP2WSXT216MsidVzUId+vPD8RKETpA2FkHVfVIMfrA/V5f
         SlAyoA3HNJOxjif8lOmDsBMWrhxqIoaQe0b3L4w+t9Q7HgmpmnAq1QpOYczq/4wgydrj
         R5jW08Xt6fTuvXh6hV0r+b5wqZiZ37CfVeUx4ilPO8ySPkQQY1etmDduRF5l9xXPlElw
         jRGMy6qybhiHmYm7ObZt6svT89P68tNjWqZa80s8C4HZCA2K6ecLvg0BRbQferukYJFh
         iKIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hhz/iZSw+eTxaAKD6erQO6gxj2fpcxGd6dd5TC5JHcU=;
        b=Z8Di68eQgUYjxIvIoJMyx3q+XrRqAf33AZFWSevPg4ei8/pHYsYb8Yt6cmrc7f/yN4
         ORW6LY6ZlvWI25SriYtqcRHewSWLfVsbesXpKVor8ehhUdRp6hJh3ntWtCj/0PQkHDQO
         7H+q1rg0AkAMtmUhM9NHNdLBQhcGnRtjDU7D0uh2AohnH4cyQQdhK/0ZoX1JvSF75lMG
         VMBqejvvS2oENhP4659Itm6g9QEgZcrHWeDzAQvZlyRVoDDUW7KVoBhx7cSND/lfirz0
         JFAELLxGloAj/J9JCxgt6kgjjgUw6UEvmmiTSr/0SzgBXlX2r8J8d548YBDUlID3/MIy
         aJrg==
X-Gm-Message-State: AOAM530rO+1ExGWjIjjtoy260w3S0uAn2HNR4zzIVE8YmYONm1/HNJsy
        8VlgVLIBfo7RRkcpkqOmszE=
X-Google-Smtp-Source: ABdhPJyWaNY9rdnpOdY2AGog+bilnrp/+5sZrUlfd+D3oEeZJoQR4Cogh1Od7QpqqUhdOC9FaKExkA==
X-Received: by 2002:a63:4206:: with SMTP id p6mr3667047pga.285.1627024197255;
        Fri, 23 Jul 2021 00:09:57 -0700 (PDT)
Received: from localhost.localdomain ([103.238.106.236])
        by smtp.gmail.com with ESMTPSA id z15sm36861038pgc.13.2021.07.23.00.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 00:09:56 -0700 (PDT)
From:   Jignesh Patel <jigs0101@gmail.com>
Cc:     jigs0101@gmail.com, Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Martin Kaiser <martin@kaiser.cx>,
        Ivan Safonov <insafonov@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Paul McQuade <paulmcquad@gmail.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: staging: rtl8188eu: Line over 100 characters
Date:   Fri, 23 Jul 2021 12:38:20 +0530
Message-Id: <20210723070827.5486-1-jigs0101@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210722164144.377781-1-jigs0101@gmail.com>
References: <20210722164144.377781-1-jigs0101@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Greg K-H, Joe Perches,

Thank you for your comments and drawn my attention.
I will modify and submit the patch again.

Regards,
Jignesh.
