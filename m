Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6641638908C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 16:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347283AbhESOT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 10:19:29 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47600 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347385AbhESOSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 10:18:31 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14JEF9YU047531;
        Wed, 19 May 2021 14:16:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=dDXCmEMCgOSpvTPk1Bzn0vOCR9ui2kUPQ/4Tdr7KMzY=;
 b=RQAJcWoCvq5jev/pmk59QtoVLdytWTvkvr4BuHd7MheM51nzR7vkBPXkwgYbpGa9StFh
 a8RpBXjQ+NhdXpLKE7oCw7r7lsASW2gjVU42rW9YqVl5jEldWlemjkuKlEekkePpaaw9
 Pd49nGtf8T3l+EA2uNmYkYgqHD6iz9gCVpDt9jUNMGqhTndSunrCQhqJPNltZ/wJxVQL
 WaUqDF6eQpGGKzJ55+PEobdOcuSyGbJhygqASGhkHbpTU8mKB+kiXDierrIw+laD0zZF
 Rz7O9mCm59w8Ffc+wkRxWH4FQfRqZsg3Ua9S93NfJgpX8GIVDKndno4nTpZMlXqtHK98 7w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 38j5qr9qh5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 May 2021 14:16:48 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14JEB9nw180057;
        Wed, 19 May 2021 14:16:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 38meeg5mt7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 May 2021 14:16:47 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14JEGlT0000773;
        Wed, 19 May 2021 14:16:47 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 38meeg5msp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 May 2021 14:16:47 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 14JEGhTb030314;
        Wed, 19 May 2021 14:16:43 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 19 May 2021 07:16:42 -0700
Date:   Wed, 19 May 2021 17:16:35 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] staging: rtl8188eu: use safe iterator in
 rtw_free_network_queue
Message-ID: <20210519141635.GE32682@kadam>
References: <20210516160613.30489-1-martin@kaiser.cx>
 <20210517155733.GK1955@kadam>
 <20210518082855.GB32682@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518082855.GB32682@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: 7s79udpuMOHUy5CW5PQVOThAIMgenLlF
X-Proofpoint-ORIG-GUID: 7s79udpuMOHUy5CW5PQVOThAIMgenLlF
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9988 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 impostorscore=0
 mlxscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105190089
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 11:28:55AM +0300, Dan Carpenter wrote:
> On Mon, May 17, 2021 at 06:57:33PM +0300, Dan Carpenter wrote:
> > Thanks for catching these...  I've created a new Smatch static checker
> > warning for this but it only works for list_for_each_entry().
> > Eventually someone would have run the coccinelle script to convert these
> > list_for_each loops into list_for_each_entry().  Otherwise you have to
> > parse container_of() and I've been meaning to do that for a while but I
> > haven't yet.
> > 
> > Anyway, I'm going to test it out overnight and see what it finds.  It's
> > sort a new use for the modification_hook(), before I had only ever used
> > it to silence warnings but this check uses it to trigger warnings.  So
> > perhaps it will generate a lot of false positives.  We'll see.
> > 
> > It sets the state of the iterator to &start at the start of the loop
> > and if it's not &start state at the end then it prints a warning.
> > 
> > regards,
> > dan carpenter
> > 
> 
> That Smatch check didn't work at all.  :P  Back to the drawing board.
> 
> regards,
> dan carpenter

It's sort of working now.  I just had to get some ordering issues fixed.
Also I had to fix a bug in smatch_conditions.c...

The check itself works very well, but the heuristic is a bit off.  It
turns out we some times mess with the list iterator very intentionally.
For example, one thing people do is add a new item directly after the
current item.

About 8 out of the 32 warnings listed below are real issues.  I'm going
to send some patches and bug fixes for them.  A couple are too ancient
for and complicated to bother with.

regards,
dan carpenter

kernel/exit.c:1397 do_wait_thread() warn: iterator 'p->sibling.next' changed during iteration
kernel/exit.c:1411 ptrace_do_wait() warn: iterator 'p->ptrace_entry.next' changed during iteration
kernel/events/core.c:3220 perf_event_modify_attr() warn: iterator 'child->child_list.next' changed during iteration
kernel/events/core.c:5451 perf_event_for_each_child() warn: iterator 'child->child_list.next' changed during iteration
kernel/locking/locktorture.c:420 torture_ww_mutex_lock() warn: iterator 'll->link.next' changed during iteration
kernel/locking/test-ww_mutex.c:464 stress_reorder_work() warn: iterator 'll->link.next' changed during iteration
arch/x86/kvm/../../../virt/kvm/kvm_main.c:4866 vm_stat_clear() warn: iterator 'kvm->vm_list.next' changed during iteration
fs/btrfs/extent-tree.c:4230 find_free_extent() warn: iterator 'block_group->list.next' changed during iteration
fs/nilfs2/segment.c:1565 nilfs_segctor_update_payload_blocknr() warn: iterator 'bh->b_assoc_buffers.next' changed during iteration
fs/super.c:657 __iterate_supers() warn: iterator 'sb->s_list.next' changed during iteration
drivers/spi/spi-fsi.c:469 fsi_spi_transfer_one_message() warn: iterator 'transfer->transfer_list.next' changed during iteration
drivers/spi/spi-tegra210-quad.c:990 tegra_qspi_transfer_one_message() warn: iterator 'transfer->transfer_list.next' changed during iteration
drivers/spi/spi.c:3299 spi_split_transfers_maxsize() warn: iterator 'xfer->transfer_list.next' changed during iteration
drivers/staging/emxx_udc/emxx_udc.c:2079 _nbu2ss_nuke() warn: iterator 'req->queue.next' changed during iteration
drivers/pnp/quirks.c:59 quirk_awe32_resources() warn: iterator 'option->list.next' changed during iteration
drivers/usb/dwc3/gadget.c:1298 dwc3_prepare_trbs() warn: iterator 'req->list.next' changed during iteration
drivers/gpu/drm/ttm/ttm_device.c:145 ttm_device_swapout() warn: iterator 'bo->lru.next' changed during iteration
drivers/gpu/drm/ttm/ttm_execbuf_util.c:91 ttm_eu_reserve_buffers() warn: iterator 'entry->head.next' changed during iteration
drivers/gpu/drm/i915/gt/intel_reset.c:901 __intel_gt_unset_wedged() warn: iterator 'tl->link.next' changed during iteration
drivers/target/target_core_user.c:1264 tcmu_tmr_notify() warn: iterator 'se_cmd->state_list.next' changed during iteration
drivers/w1/w1.c:1265 w1_fini() warn: iterator 'dev->w1_master_entry.next' changed during iteration
drivers/scsi/libsas/sas_port.c:47 sas_resume_port() warn: iterator 'dev->dev_list_node.next' changed during iteration
drivers/scsi/lpfc/lpfc_hbadisc.c:993 lpfc_linkup_cleanup_nodes() warn: iterator 'ndlp->nlp_listp.next' changed during iteration
drivers/scsi/lpfc/lpfc_hbadisc.c:4983 lpfc_unreg_hba_rpis() warn: iterator 'ndlp->nlp_listp.next' changed during iteration
drivers/block/drbd/drbd_debugfs.c:311 seq_print_resource_transfer_log_summary() warn: iterator 'req->tl_requests.next' changed during iteration
drivers/infiniband/hw/mlx5/main.c:3285 mlx5_ib_init_multiport_master() warn: iterator 'mpi->list.next' changed during iteration
drivers/infiniband/core/verbs.c:1112 __ib_shared_qp_event_handler() warn: iterator 'event->element.qp->open_list.next' changed during iteration
net/core/devlink.c:10589 devlink_pernet_pre_exit() warn: iterator 'devlink->list.next' changed during iteration
net/bluetooth/l2cap_core.c:1726 l2cap_conn_ready() warn: iterator 'chan->list.next' changed during iteration
net/bluetooth/l2cap_core.c:6265 l2cap_ecred_reconf_rsp() warn: iterator 'chan->list.next' changed during iteration
net/bluetooth/l2cap_core.c:8209 l2cap_security_cfm() warn: iterator 'chan->list.next' changed during iteration
security/landlock/fs.c:347 hook_sb_delete() warn: iterator 'inode->i_sb_list.next' changed during iteration

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

static void set_watch(struct sm_state *sm, struct expression *mod_expr)
{
	if (mod_expr && stmt_matches(mod_expr, post_stmt))
		return;
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
	add_hook(match_pre_statement, ASSIGNMENT_HOOK_AFTER);
	add_hook(match_post_statement, ASSIGNMENT_HOOK);

	add_modification_hook(my_id, &set_watch);
}


