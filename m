Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C060383973
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 18:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238995AbhEQQQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 12:16:53 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51166 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344974AbhEQQAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 12:00:14 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14HFn2Nf149176;
        Mon, 17 May 2021 15:57:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=46zegLTyORjCsXmwBaOGpVU+tbqb7CJ5loKuJs3uNxI=;
 b=LoOhFOOChJ1O0mbu+1ddqtqACKixTcROK0cYkmViFNP/xYon6ykXEhyvQ12VKxKIL2Qu
 yHkBvo4uUh3AkjEUaQpOKkSfUh2TAA+EOu272cKjBgUM/x/7J+iBXGgTMadpxd1Ww9dA
 h5C26sZ8QI3q6Pp2GP0SGK5b72P0/LTYoB1M3PM3/KpcRrtATcgyJql6QoTJok4Y1PqB
 6z2FwKwqv43Gq6Hewj2+t18bw/d82aLsgkUru6ZoOtXxcms0HKlOo/FZ5wIoNYEFG1Pq
 qKrZU1Zhdxc9qVaCI9RFeTj3QVupbqwmyGM9TC3nuG99Nn7aDnp1Ke10ofdZAlQNFqb9 hQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 38j5qr3q5b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 May 2021 15:57:48 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14HFjnoo066746;
        Mon, 17 May 2021 15:57:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 38j645y8j7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 May 2021 15:57:47 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14HFt3QU150609;
        Mon, 17 May 2021 15:57:47 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 38j645y8gf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 May 2021 15:57:46 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 14HFvfJx029187;
        Mon, 17 May 2021 15:57:41 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 17 May 2021 08:57:40 -0700
Date:   Mon, 17 May 2021 18:57:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] staging: rtl8188eu: use safe iterator in
 rtw_free_network_queue
Message-ID: <20210517155733.GK1955@kadam>
References: <20210516160613.30489-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210516160613.30489-1-martin@kaiser.cx>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: HW1ESqbzC4QZTidz2X09wEVQvnux-4f8
X-Proofpoint-ORIG-GUID: HW1ESqbzC4QZTidz2X09wEVQvnux-4f8
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9987 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 impostorscore=0
 mlxscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105170109
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for catching these...  I've created a new Smatch static checker
warning for this but it only works for list_for_each_entry().
Eventually someone would have run the coccinelle script to convert these
list_for_each loops into list_for_each_entry().  Otherwise you have to
parse container_of() and I've been meaning to do that for a while but I
haven't yet.

Anyway, I'm going to test it out overnight and see what it finds.  It's
sort a new use for the modification_hook(), before I had only ever used
it to silence warnings but this check uses it to trigger warnings.  So
perhaps it will generate a lot of false positives.  We'll see.

It sets the state of the iterator to &start at the start of the loop
and if it's not &start state at the end then it prints a warning.

regards,
dan carpenter

/*
 * Copyright (C) 2021 Oracle.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, see http://www.gnu.org/copyleft/gpl.txt
 */

#include "smatch.h"
#include "smatch_extra.h"

static int my_id;

STATE(start);
STATE(watch);

static struct statement *iterator_stmt, *pre_stmt, *post_stmt;

static void set_watch(struct sm_state *sm, struct expression *mod_expr)
{
	set_state(my_id, sm->name, sm->sym, &watch);
}

static bool is_list_macro(const char *macro)
{
	if (strcmp(macro, "list_for_each_entry") == 0)
		return true;
	return false;
}

static void match_iterator_statement(struct statement *stmt)
{
	const char *macro;

	if (stmt->type != STMT_ITERATOR ||
	    !stmt->iterator_pre_statement ||
	    !stmt->iterator_post_statement)
		return;

	macro = get_macro_name(stmt->pos);
	if (!macro)
		return;
	if (!is_list_macro(macro))
		return;

	iterator_stmt = stmt;
	pre_stmt = stmt->iterator_pre_statement;
	post_stmt = stmt->iterator_post_statement;
}

static bool stmt_matches(struct expression *expr, struct statement *stmt)
{
	struct expression *tmp;
	struct statement *parent;

	if (!stmt)
		return false;
	while ((tmp = expr_get_parent_expr(expr)))
		expr = tmp;

	parent = expr_get_parent_stmt(expr);
	return parent == stmt;
}

static char *get_iterator_member(void)
{
	struct expression *expr;

	if (!iterator_stmt ||
	    !iterator_stmt->iterator_pre_condition)
		return NULL;

	expr = iterator_stmt->iterator_pre_condition;
	if (expr->type != EXPR_PREOP || expr->op != '!')
		return NULL;
	expr = strip_parens(expr->unop);
	if (expr->type != EXPR_COMPARE)
		return NULL;
	expr = strip_parens(expr->left);
	if (expr->type != EXPR_PREOP || expr->op != '&')
		return NULL;
	expr = strip_expr(expr->unop);
	if (expr->type != EXPR_DEREF || !expr->member)
		return NULL;
	return expr->member->name;
}

static void match_pre_statement(struct expression *expr)
{
	char *name, *member;
	struct symbol *sym;
	char buf[64];

	if (!stmt_matches(expr, pre_stmt))
		return;

	name = expr_to_var_sym(expr->left, &sym);
	if (!name)
		return;
	member = get_iterator_member();

	snprintf(buf, sizeof(buf), "%s->%s.next", name, member);
	set_state(my_id, buf, sym, &start);
}

static void match_post_statement(struct expression *expr)
{
	struct smatch_state *state;
	char *name, *member;
	struct symbol *sym;
	char buf[64];

	if (!stmt_matches(expr, post_stmt))
		return;

	name = expr_to_var_sym(expr->left, &sym);
	if (!name)
		return;
	member = get_iterator_member();

	snprintf(buf, sizeof(buf), "%s->%s.next", name, member);
	state = get_state(my_id, buf, sym);
	if (!state || state == &start)
		return;

	sm_warning("iterator '%s' changed during iteration", buf);
}

void check_list_set_inside(int id)
{
	my_id = id;

	if (option_project != PROJ_KERNEL)
		return;

	add_hook(match_iterator_statement, STMT_HOOK);
	add_hook(match_pre_statement, ASSIGNMENT_HOOK);
	add_hook(match_post_statement, ASSIGNMENT_HOOK);

	add_modification_hook(my_id, &set_watch);
}

