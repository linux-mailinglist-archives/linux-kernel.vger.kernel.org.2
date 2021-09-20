Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBBB4118DB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 18:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238046AbhITQHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 12:07:36 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:10920 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232262AbhITQHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 12:07:35 -0400
Received: from bender.morinfr.org (unknown [82.64.86.27])
        by smtp4-g21.free.fr (Postfix) with ESMTPS id B75D519F5B2;
        Mon, 20 Sep 2021 18:06:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=morinfr.org
        ; s=20170427; h=In-Reply-To:Content-Type:MIME-Version:References:Reply-To:
        Message-ID:Subject:Cc:To:From:Date:Sender:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=RKjXYi91sm7Ea3vEffGcG1Ew3/UF7y6Pi6GRhcrx0wg=; b=KvHy/Y8YvXwYnJsW5LdSvbfmWe
        9qYtrqlZwlkk1jMGs+PMwEBHJ5Fj+z3X4rgZyPa6+YjM3kRxMsTVmbjJ93dKua+iIonQdWlI5iaGH
        QWHBDibmYPTpCWAmmdVt4xTXYvlnNLQxl92q6SZjDiX5lMQtHBC7StWrnRYpxEFGKIJA=;
Received: from guillaum by bender.morinfr.org with local (Exim 4.92)
        (envelope-from <guillaume@morinfr.org>)
        id 1mSLnY-000058-EI; Mon, 20 Sep 2021 18:05:40 +0200
Date:   Mon, 20 Sep 2021 18:05:40 +0200
From:   Guillaume Morin <guillaume@morinfr.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: call_rcu data race patch
Message-ID: <20210920160540.GA31426@bender.morinfr.org>
Reply-To: Guillaume Morin <guillaume@morinfr.org>
Mail-Followup-To: "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20210917191555.GA2198@bender.morinfr.org>
 <20210917211148.GU4156@paulmck-ThinkPad-P17-Gen-1>
 <20210917213404.GA14271@bender.morinfr.org>
 <20210917220700.GV4156@paulmck-ThinkPad-P17-Gen-1>
 <20210918003933.GA25868@bender.morinfr.org>
 <20210918040035.GX4156@paulmck-ThinkPad-P17-Gen-1>
 <20210918070836.GA19555@bender.morinfr.org>
 <20210919163539.GD880162@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210919163539.GD880162@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Sep  9:35, Paul E. McKenney wrote:
> How is the testing of the patches going?  (I am guessing nothing yet
> based on the failure times, but who knows?)

Nothing yet. I think we'll have a better idea by wednesday.

Guillaume.

-- 
Guillaume Morin <guillaume@morinfr.org>
