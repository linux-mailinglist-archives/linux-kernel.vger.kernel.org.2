Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFD2424C48
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 05:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240091AbhJGDvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 23:51:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58201 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232310AbhJGDvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 23:51:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633578566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=se/vuWw2glig37I2NznMgKiRi0nqgatQfnx7PaiYJE8=;
        b=c4wpe45mD0WPIR8MXpNOf/wBm89Cd1UvelXxcqtqc7e0jttXSUbyk/ArIBSsFQ6WWJa7+s
        4XrAg+NOJnoRl7cL71RBf9fzJSvB0NUkjBEsX4FXIPBdHV0AhFq0mXoelv7iIy6FeFhZrL
        zkl3pCZlVvh9DIxNrmesXHzGZ1VM7IU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-5GZymGtuMiO2c_nydFKhrg-1; Wed, 06 Oct 2021 23:49:24 -0400
X-MC-Unique: 5GZymGtuMiO2c_nydFKhrg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5121E1006AA6;
        Thu,  7 Oct 2021 03:49:23 +0000 (UTC)
Received: from [10.22.32.238] (unknown [10.22.32.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C01B360936;
        Thu,  7 Oct 2021 03:49:22 +0000 (UTC)
Message-ID: <4988d521-472f-a50e-4686-52afde08d2e9@redhat.com>
Date:   Wed, 6 Oct 2021 23:49:22 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>, mingo@redhat.com,
        LKML <linux-kernel@vger.kernel.org>
From:   William Cohen <wcohen@redhat.com>
Subject: Reason for unused flags argument in trace_raw_output_* function?
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have some code that analyzes x86_64 binaries (https://developers.redhat.com/articles/2021/08/09/debugging-function-parameters-
dyninst#liveness_analysis) and list which function parameters are unused.  I noticed that trace_raw_output_* functions have an unused flags argument.  I assume this is is to make the argument list match up with some other function, but I couldn't see which function(s) the trace_raw_output_* functions are trying to match up with.  Which functions are the trace_raw_output_* function's arguments trying to match?


-Will Cohen

